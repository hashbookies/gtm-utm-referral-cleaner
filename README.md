# UTM and Referral Cleaner

GTM variable template that returns a normalized page path with tracking parameters removed.

## Overview

UTM and Referral Cleaner is a Google Tag Manager custom variable template that returns a normalized page path with common tracking parameters removed while preserving meaningful non-tracking query parameters.

This template is intended for reporting hygiene. It helps reduce page path fragmentation caused by UTMs, click IDs, and other tracking query strings. It does not replace attribution capture.

## What it does

- Removes common UTM parameters.
- Removes common ad click identifiers.
- Preserves non-tracking query parameters.
- Can return either path only or path plus cleaned query string.
- Can optionally remove URL fragments.

## When to use it

- Use it for cleaner page path reporting in GA4 or other analytics tools.
- Use it when tracking parameters create many duplicate page path rows.
- Use it when you want a reporting-safe page path variable in GTM.

## When not to use it

- Do not use it as an attribution capture solution.
- Do not use it to modify the browser URL. This template only returns a variable value.
- Do not use it if you need to preserve every query parameter exactly as received.

## Setup

1. In Google Tag Manager, go to **Templates**.
2. Under **Variable Templates**, click **New**.
3. Open the three-dot menu and choose **Import**.
4. Import `template.tpl`.
5. Save the template.
6. Create a new variable using **UTM and Referral Cleaner**.

## Configuration

### Return Mode

- `Path only`: returns only the path.
- `Path and cleaned query`: returns the path plus non-tracking query parameters that remain after cleanup.

### Remove URL Fragment

When enabled, removes the URL fragment from the returned value.

### Additional Parameters To Remove

Optional comma-separated list of extra query parameters to strip.

Example:

```text
partner_id,session_debug,test_param
```

## Output example

Input URL:

```text
https://example.com/pricing?utm_source=newsletter&gclid=123&plan=pro
```

Output with `Path and cleaned query`:

```text
/pricing?plan=pro
```

Output with `Path only`:

```text
/pricing
```

## Limitations

- This template does not modify the browser URL.
- This template does not capture or preserve attribution data.
- This template only removes parameters from the value it returns.
- Review custom parameters before removing them to avoid dropping meaningful reporting context.

## Maintainer

Created and maintained by Tayo Kolade.

This template is part of a small collection of independent open-source Google Tag Manager utilities for general measurement and reporting use cases.

## Disclaimer

This is an independent open-source utility created for general Google Tag Manager use cases. It is not affiliated with or endorsed by Google or any third-party platform provider.
