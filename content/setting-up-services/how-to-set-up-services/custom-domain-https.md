+++
title = "Use a Custom Domain with HTTPS"
date = 2026-11-12T10:00:00-05:00
weight = 12
+++

By default, Tugboat generates Preview URLs on `tugboatqa.com`, and serves them over HTTPS with a valid certificate. If
you set a custom [`domain`](/reference/tugboat-configuration/#domain) for a Service, or use
[`alias_type: domain`](/reference/tugboat-configuration/#alias_type), Tugboat's certificate doesn't cover your hostname,
so browsers show a certificate warning when the Service uses `https: true`.

To serve Previews on your own domain with a valid certificate, put [Cloudflare](https://www.cloudflare.com/) in front of
it. Cloudflare presents its own certificate for your domain to visitors, and connects to Tugboat over HTTPS behind the
scenes.

### Before you start

- Your domain's DNS must be managed by Cloudflare.
- We recommend a separate domain that's dedicated to Previews, such as `example-previews.com`, set up as its own zone in
  Cloudflare. The steps below change SSL/TLS and caching settings, and a dedicated zone keeps those changes away from
  your production site.
- If your Previews must share a zone with production, use [subpath URLs](/reference/tugboat-configuration/#subpath).
  Previews are then served from a single hostname, so you can scope the SSL/TLS and caching settings to that one
  hostname. Subdomain Preview URLs, such as `pr123-token.example.com`, have no pattern that separates them from your
  production hostnames. The hostname depends on which setting you use:
  - With `domain: example.com`, Tugboat adds `preview.` to the domain, and serves Previews from `preview.example.com`.
  - With `alias_type: domain`, Tugboat uses each value in `aliases` as the hostname, and adds nothing to it. Set the
    alias to a hostname that only Previews use, such as `preview.example.com`.

{{% notice warning %}} **Don't set an alias to a hostname that your production site uses.** With `alias_type: domain`
and subpath URLs, `aliases: ['example.com']` generates Preview URLs on `example.com` itself, and the DNS record in step
2 would point `example.com` at Tugboat instead of your production site. Only use the zone's root domain as an alias in a
zone that's dedicated to Previews. {{% /notice %}}

### Choose a domain that Cloudflare's free certificate covers

Cloudflare's free [Universal SSL](https://developers.cloudflare.com/ssl/edge-certificates/universal-ssl/) certificate
covers `example.com` and `*.example.com`, but not deeper levels such as `*.previews.example.com`. Certificates for
deeper levels require
[Advanced Certificate Manager](https://developers.cloudflare.com/ssl/edge-certificates/advanced-certificate-manager/) or
[Total TLS](https://developers.cloudflare.com/ssl/edge-certificates/additional-options/total-tls/).

To stay on the free plan, set `domain` to the zone's root domain, such as `example.com`, rather than a subdomain such as
`previews.example.com`:

| Configuration                                   | Preview URLs look like                     | Hostnames to cover    |
| :---------------------------------------------- | :----------------------------------------- | :-------------------- |
| `domain: example.com`                           | `https://pr123-token.example.com`          | `*.example.com`       |
| `domain: example.com` with subpath              | `https://preview.example.com/pr123-token/` | `preview.example.com` |
| `aliases: ['example.com']`                      | `https://pr123-token.example.com`          | `*.example.com`       |
| `aliases: ['example.com']` with subpath         | `https://example.com/pr123-token/`         | `example.com`         |
| `aliases: ['preview.example.com']` with subpath | `https://preview.example.com/pr123-token/` | `preview.example.com` |

The `aliases` rows assume `alias_type: domain`. With subpath URLs, `domain` and `aliases` generate different hostnames
from the same value: Tugboat serves `domain: example.com` from `preview.example.com`, and serves
`aliases: ['example.com']` from `example.com`.

Without subpath URLs, `aliases: ['preview.example.com']` generates URLs such as
`https://pr123-token.preview.example.com`, which the free certificate doesn't cover.

### 1. Configure the custom domain in Tugboat

In your [Tugboat configuration file](/setting-up-tugboat/create-a-tugboat-config-file/), set `domain` on the Service,
and leave `https` set to `true`, which is the default:

```yaml
services:
  webserver:
    image: tugboatqa/httpd:2.4
    default: true
    domain: example.com
```

To use subpath URLs instead, also set [`subpath: true`](/reference/tugboat-configuration/#subpath).

If you're using [`aliases`](/reference/tugboat-configuration/#aliases) with
[`alias_type: domain`](/reference/tugboat-configuration/#alias_type), repeat the following steps for each alias domain,
using the alias hostnames from the table above.

### 2. Add a proxied DNS record in Cloudflare

In the Cloudflare dashboard, go to **DNS** > **Records** for your domain, and add a `CNAME` record that points to
`previews.tugboatqa.com`:

| Configuration                                        | Name      | Target                   | Proxy status |
| :--------------------------------------------------- | :-------- | :----------------------- | :----------- |
| Subdomain URLs (the default)                         | `*`       | `previews.tugboatqa.com` | Proxied      |
| Subpath URLs with `domain: example.com`              | `preview` | `previews.tugboatqa.com` | Proxied      |
| Subpath URLs with `aliases: ['preview.example.com']` | `preview` | `previews.tugboatqa.com` | Proxied      |
| Subpath URLs with `aliases: ['example.com']`         | `@`       | `previews.tugboatqa.com` | Proxied      |

The `aliases` rows assume `alias_type: domain`. For subpath URLs with an alias, the record name is the alias hostname
itself.

Only add the `@` record in a zone that's dedicated to Previews. In a zone shared with production, the `@` record points
your root domain at Tugboat instead of your production site. Cloudflare supports a `CNAME` on the root domain (`@`)
through [CNAME flattening](https://developers.cloudflare.com/dns/cname-flattening/).

The record must be **Proxied** (orange cloud). A **DNS only** record sends visitors straight to Tugboat, and they'll see
the same certificate warning as before.

A wildcard record doesn't override records you've already defined, such as `www`, so your other hostnames keep working.

### 3. Set the SSL/TLS encryption mode to Full

Go to **SSL/TLS** > **Overview**, and set the encryption mode to **Full**.

Don't use **Full (strict)**. In strict mode, Cloudflare validates the certificate Tugboat presents, which is issued for
`tugboatqa.com` and not your domain, so every request fails with a
[526 error](https://developers.cloudflare.com/support/troubleshooting/http-status-codes/cloudflare-5xx-errors/error-526/).

In **Full** mode, traffic between Cloudflare and Tugboat is encrypted, but Cloudflare doesn't verify Tugboat's
certificate. Traffic between visitors and Cloudflare is encrypted and uses a valid certificate.

The encryption mode applies to the whole zone. If your production site shares the zone and uses **Full (strict)**, keep
that setting, and instead add a [Configuration Rule](https://developers.cloudflare.com/rules/configuration-rules/) that
sets SSL to **Full** only for requests where **Hostname** equals your Preview hostname, such as `preview.example.com`.

Cloudflare's
[Automatic SSL/TLS](https://developers.cloudflare.com/ssl/origin-configuration/ssl-modes/#automatic-ssltls-default)
option periodically scans your origin, and can change the zone's encryption mode to a stricter one, such as **Full
(strict)**. In a zone dedicated to Previews, choose **Custom SSL/TLS** instead of **Automatic SSL/TLS** when you select
**Full**, so that the encryption mode stays where you set it. In a zone shared with production, the Configuration Rule
sets the encryption mode for the Preview hostname separately from the zone's encryption mode.

### 4. Bypass the Cloudflare cache for Previews

Cloudflare caches static assets such as CSS, JavaScript, and images by default. After you rebuild or refresh a Preview,
visitors could see stale files from the cache instead of the new ones.

To prevent this, go to **Caching** > **Cache Rules**, and create a rule that bypasses the cache for your Previews:

1. Under **If incoming requests match**, choose which requests the rule applies to:
   - In a zone dedicated to Previews, choose **All incoming requests**.
   - In a zone shared with production, choose **Custom filter expression**, and set **Field** to **Hostname**,
     **Operator** to **equals**, and **Value** to your Preview hostname, such as `preview.example.com`.
2. Under **Cache eligibility**, choose **Bypass cache**.
3. Save and deploy the rule.

### 5. Test the Preview URL

Build or rebuild a Preview, then open its URL. The browser should load it over HTTPS without a certificate warning. If
you see a warning, check that the DNS record is proxied, and that Cloudflare's certificate covers the hostname.
