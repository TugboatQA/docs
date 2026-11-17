+++
title = "Use a Custom Domain with HTTPS"
date = 2026-11-12T10:00:00-05:00
weight = 12
+++

By default, Tugboat generates Preview URLs on `tugboatqa.com`, and serves them over HTTPS with a valid certificate. If
you set a custom [`domain`](/reference/tugboat-configuration/#domain) for a Service, or use
[`alias_type: domain`](/reference/tugboat-configuration/#alias_type), Tugboat's certificate doesn't cover your hostname,
so browsers show a certificate warning when the Service uses `https: true`.

To serve Previews on your own domain with a valid certificate, proxy the domain through
[Cloudflare](https://www.cloudflare.com/). Cloudflare presents its own certificate for your domain to visitors, and
forwards their HTTPS requests to Tugboat over HTTPS.

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

This example generates subdomain Preview URLs, such as `https://pr123-token.example.com`, so only use it in a zone
that's dedicated to Previews. To use subpath URLs instead, also set
[`subpath: true`](/reference/tugboat-configuration/#subpath).

To use [`aliases`](/reference/tugboat-configuration/#aliases) instead of `domain`, set
[`alias_type: domain`](/reference/tugboat-configuration/#alias_type). The following example serves Previews from
`https://preview.example.com/pr123-token/`, which suits a zone shared with production:

```yaml
services:
  webserver:
    image: tugboatqa/httpd:2.4
    default: true
    subpath: true
    alias_type: domain
    aliases:
      - preview.example.com
```

Tugboat generates alias URLs in addition to the normal Service URL. With this example, the Preview also keeps its URL on
`preview.tugboatqa.com`, and the alias URL is the one that uses your domain.

If you list more than one alias, repeat the following steps for each alias domain, using the alias hostnames from the
table above.

### 2. Add a proxied DNS record in Cloudflare

In the Cloudflare dashboard, go to **DNS** > **Records** for your domain, and add a `CNAME` record that points to
`previews.tugboatqa.com`:

| Configuration                                                           | Name      | Target                   | Proxy status |
| :---------------------------------------------------------------------- | :-------- | :----------------------- | :----------- |
| Subdomain URLs with `domain: example.com` or `aliases: ['example.com']` | `*`       | `previews.tugboatqa.com` | Proxied      |
| Subpath URLs with `domain: example.com`                                 | `preview` | `previews.tugboatqa.com` | Proxied      |
| Subpath URLs with `aliases: ['preview.example.com']`                    | `preview` | `previews.tugboatqa.com` | Proxied      |
| Subpath URLs with `aliases: ['example.com']`                            | `@`       | `previews.tugboatqa.com` | Proxied      |

The `aliases` values assume `alias_type: domain`. For subpath URLs with an alias, the record name is the alias hostname
itself. For subdomain URLs with an alias that isn't the zone's root domain, such as `preview.example.com`, the record
name is a wildcard below the alias, such as `*.preview`.

Only add the `*` or `@` record in a zone that's dedicated to Previews. Don't add either record in a zone shared with
production:

- The `*` record points every hostname that has no DNS record of its own at Tugboat. Hostnames with their own records,
  such as `www`, keep working, but you can't scope the SSL/TLS and caching settings in the following steps to Preview
  hostnames only.
- The `@` record points your root domain at Tugboat instead of your production site.

Cloudflare supports a `CNAME` on the root domain (`@`) through
[CNAME flattening](https://developers.cloudflare.com/dns/cname-flattening/).

The record must be **Proxied** (orange cloud). A **DNS only** record sends visitors straight to Tugboat, and they'll see
the same certificate warning as before.

### 3. Set the SSL/TLS encryption mode to Full

Cloudflare must use the **Full** encryption mode for your Preview hostnames, and not **Full (strict)**. In strict mode,
Cloudflare validates the certificate Tugboat presents, which is issued for `tugboatqa.com` and not your domain, so every
request fails with a
[526 error](https://developers.cloudflare.com/support/troubleshooting/http-status-codes/cloudflare-5xx-errors/error-526/).

Where you set the encryption mode depends on the zone:

- **In a zone dedicated to Previews**, go to **SSL/TLS** > **Overview**, choose **Custom SSL/TLS**, and set the
  encryption mode to **Full**.
- **In a zone shared with production**, don't change the zone's encryption mode, because it also applies to your
  production site. Instead, add a [Configuration Rule](https://developers.cloudflare.com/rules/configuration-rules/)
  that sets SSL to **Full** only for requests where **Hostname** equals your Preview hostname, such as
  `preview.example.com`.

In both cases, we recommend **Custom SSL/TLS** instead of
[**Automatic SSL/TLS**](https://developers.cloudflare.com/ssl/origin-configuration/ssl-modes/#automatic-ssltls-default)
on the **SSL/TLS** > **Overview** page. Automatic SSL/TLS periodically scans your origin, and can change the zone's
encryption mode to a stricter one, such as **Full (strict)**. With Custom SSL/TLS, the zone's encryption mode stays
where you set it. Cloudflare's documentation doesn't state whether a Configuration Rule still applies after Automatic
SSL/TLS raises the zone's encryption mode.

In [**Full**](https://developers.cloudflare.com/ssl/origin-configuration/ssl-modes/full/) mode, Cloudflare connects to
Tugboat with the same protocol that the visitor uses:

- When a visitor uses HTTPS, traffic between the visitor and Cloudflare is encrypted and uses a valid certificate.
  Traffic between Cloudflare and Tugboat is also encrypted, but Cloudflare doesn't verify Tugboat's certificate.
- When a visitor uses HTTP, Cloudflare connects to Tugboat over unencrypted HTTP.

To redirect HTTP requests to HTTPS at Cloudflare, go to **SSL/TLS** > **Edge Certificates**, and turn on
[**Always Use HTTPS**](https://developers.cloudflare.com/ssl/edge-certificates/additional-options/always-use-https/).
This setting applies to every hostname in the zone. In a zone shared with production, if you don't want the setting for
the whole zone, create a redirect rule for your Preview hostname instead, as Cloudflare's Always Use HTTPS documentation
describes.

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

Build or rebuild a Preview, then open its URL on your domain. If you use `aliases`, open the alias URL, and not the
Preview's URL on `tugboatqa.com`. The browser should load it over HTTPS without a certificate warning. If you see a
warning, check that the DNS record is proxied, and that Cloudflare's certificate covers the hostname.

If you recently added the domain to Cloudflare, the certificate might not be issued yet. Cloudflare can take from 15
minutes to 24 hours after it activates a domain to issue the Universal SSL certificate. Go to **SSL/TLS** > **Edge
Certificates** to check the certificate's status.
