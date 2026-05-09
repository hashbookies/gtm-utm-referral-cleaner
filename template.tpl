___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_dd_utm_referral_cleaner",
  "version": 1,
  "displayName": "UTM and Referral Cleaner",
  "categories": [
    "ANALYTICS",
    "UTILITY",
    "ATTRIBUTION"
  ],
  "description": "Returns a normalized page path with common tracking parameters removed while preserving meaningful non-tracking query parameters.",
  "containerContexts": [
    "WEB"
  ],
  "securityGroups": []
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "returnMode",
    "displayName": "Return Mode",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "pathOnly",
        "displayValue": "Path only"
      },
      {
        "value": "pathAndQuery",
        "displayValue": "Path and cleaned query"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "pathAndQuery",
    "help": "Choose whether the variable returns only the path or the path plus any remaining non-tracking query parameters."
  },
  {
    "type": "CHECKBOX",
    "name": "removeFragment",
    "checkboxText": "Remove URL fragment",
    "simpleValueType": true,
    "help": "Enable this to remove the URL fragment from the returned value."
  },
  {
    "type": "TEXT",
    "name": "extraParametersToStrip",
    "displayName": "Additional Parameters To Remove",
    "simpleValueType": true,
    "help": "Enter extra query parameters to remove, separated by commas.",
    "valueHint": "param1,param2"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const getUrl = require('getUrl');
const getType = require('getType');
const makeString = require('makeString');

const normalize = function(value) {
  if (getType(value) !== 'string') return '';
  return makeString(value).trim();
};

const normalizeKey = function(value) {
  return normalize(value).toLowerCase();
};

const splitList = function(value) {
  const normalized = normalize(value);
  if (!normalized) return [];
  return normalized.split(',').map(function(item) {
    return normalizeKey(item);
  }).filter(function(item) {
    return item.length > 0;
  });
};

const trackingKeys = {
  utm_source: true,
  utm_medium: true,
  utm_campaign: true,
  utm_id: true,
  utm_term: true,
  utm_content: true,
  utm_source_platform: true,
  utm_marketing_tactic: true,
  utm_creative_format: true,
  gclid: true,
  dclid: true,
  fbclid: true,
  msclkid: true,
  ttclid: true,
  li_fat_id: true,
  twclid: true,
  obclid: true,
  gbraid: true,
  wbraid: true,
  srsltid: true,
  mc_cid: true,
  mc_eid: true
};

splitList(data.extraParametersToStrip).forEach(function(key) {
  trackingKeys[key] = true;
});

const path = normalize(getUrl('path')) || '/';
const query = normalize(getUrl('query'));
const fragment = normalize(getUrl('fragment'));

if (data.returnMode === 'pathOnly') {
  return data.removeFragment && fragment ? path : path + (fragment ? '#' + fragment : '');
}

if (!query) {
  return data.removeFragment && fragment ? path : path + (fragment ? '#' + fragment : '');
}

const pairs = query.split('&').filter(function(part) {
  return part.length > 0;
});

const keptPairs = [];
for (let i = 0; i < pairs.length; i++) {
  const pair = pairs[i];
  const separatorIndex = pair.indexOf('=');
  const key = separatorIndex === -1 ? pair : pair.slice(0, separatorIndex);
  const normalizedKey = normalizeKey(key);
  if (!trackingKeys[normalizedKey]) {
    keptPairs.push(pair);
  }
}

const cleanedQuery = keptPairs.join('&');
const baseValue = cleanedQuery ? path + '?' + cleanedQuery : path;

if (data.removeFragment || !fragment) {
  return baseValue;
}

return baseValue + '#' + fragment;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Community-ready template for returning reporting-safe page paths with tracking parameters removed.
