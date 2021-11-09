---
title: "Configure Lighthouse"
date: 2020-09-23T15:29:49-04:00
weight: 1
---

How to configure Lighthouse accessibility, SEO, and web-development best-practices audits against your Tugboat Previews

- [Simple Lighthouse configuration](#simple-lighthouse-configuration)
- [Use a custom Lighthouse configuration](#use-a-custom-lighthouse-configuration)
- [Specify Lighthouse settings per-URL](#specify-lighthouse-settings-per-url)
- [Group Lighthouse reports via service alias](#group-lighthouse-reports-via-service-alias)

When Tugboat completes Google Lighthouse audits of your specified URLs, you'll be able to view the Lighthouse reports
right in the Tugboat Dashboard. For more info about what you'll see, check out:
[View Lighthouse Reports](../view-lighthouse-reports/).

{{% notice tier %}} This feature is available for [Tugboat Premium plans](https://www.tugboat.qa/premium). If you'd like
to run Lighthouse audits against your Tugboat Previews, but you're on a different tier, you'll need to upgrade your
project to Premium.{{% /notice %}}

If you want to trigger Lighthouse audits for specific URLs, but turn visual diffs off for those urls, see:
[Turn off visual diffs](/visual-diffs/configure-visual-diffs/#turn-off-visual-diffs).

## Simple Lighthouse configuration

To configure which pages get Lighthouse accessibility, SEO, and best practices audits, specify the _relative URLs_ of
the pages in a `urls` key in the [service definition](/setting-up-services/). In this format, each URL can be a string,
and you can list multiple urls.

```yaml
services:
  apache:
    urls:
      # Conduct Lighthouse audits of the these URLs using the default options
      - /
      - /blog
      - /about
```

## Use a custom Lighthouse configuration

Tugboat uses the default Lighthouse configuration, but disables some server performance metrics. If you'd like to use a
custom Lighthouse configuration, to tweak audit scoring or add custom checks, you can pass a custom Lighthouse
configuration object to use when generating reports.

Check out
[the `GoogleChrome/Lighthouse` blob on GitHub](https://github.com/GoogleChrome/lighthouse/blob/HEAD/docs/configuration.md)
for more information about creating a custom Lighthouse config.

```yaml
services:
  apache:
    # Specify a custom config object to use to conduct Lighthouse audits
    lighthouse:
      config:
        extends: lighthouse:default
        settings:
          onlyAudits:
            - first-meaningful-paint
            - speed-index
            - interactive
    urls:
      # Conduct Lighthouse audits of the these URLs using the custom config
      - /
      - /blog
      - /about
```

{{% notice tip %}} In addition to formatting the Lighthouse custom config object as YAML in the example above, you can
also copy/paste JSON directly from the Google Lighthouse blob into your Tugboat config, since YAML is a superset of
JSON. Example follows.{{% /notice %}}

## Specify Lighthouse settings per-URL

You can also specify `lighthouse` configuration options on a per `url` basis. For more information, see:
[Tugboat Configuration -> urls](/reference/tugboat-configuration/#urls).

```yaml
services:
  apache:
    urls:
      # Trigger a Lighthouse audit of the home page using the default options
      - url: /

      # Trigger a Lighthouse audit for /blog, but override the default config with a custom config object
      - url: /blog
        lighthouse:
          config: {
            extends: 'lighthouse:default',
            settings: {
              onlyAudits: [
                'first-meaningful-paint',
                'speed-index',
                'interactive',
              ],
            }

      # Turn off Lighthouse audits for /about, but leave the URL in the list for other Service URL activities, such as generating visual diffs
      - url: /about
        lighthouse:
          enabled: false
```

## Group Lighthouse reports via service alias

You can also group URLs by [service alias](/reference/tugboat-configuration/#aliases), which is convenient when aliases
have different URL structures.

```yaml
services:
  apache:
    aliases:
      - foo

    urls:
      # Trigger Lighthouse audits for the default alias
      :default:
        - /
        - /blog

      # Trigger Lighthouse audits for the "foo" alias
      foo:
        - /
        - /about
```

{{% notice tip %}} If you're not running an `apache` service on your Preview, but you _are_ running `php`, set up
Lighthouse under the `php` service. {{% /notice %}}
