---
title: "Configure Lighthouse Audits"
date: 2020-09-23T15:29:49-04:00
weight: 1
---

How to configure Lighthouse accessibility, SEO, and web-development best-practices audits against your Tugboat Previews

- [Simple Lighthouse configuration](#simple-lighthouse-configuration)
- [Use a custom Lighthouse configuration file](#use-a-custom-lighthouse-configuration-file)
- [Specify Lighthouse settings per-URL](#specify-lighthouse-settings-per-url)
- [Group Lighthouse reports via service alias](#group-lighthouse-reports-via-service-alias)

{{% notice tier %}} This feature is only available to [Tugboat Enterprise](https://www.tugboat.qa/enterprise) or
On-Premise subscribers. If you'd like to run Lighthouse audits against your Tugboat Previews,
[contact us](https://www.tugboat.qa/contact/) to update your project to an Enterprise subscription.{{% /notice %}}

If you want to generate Lighthouse reports for specific URLs, but turn visual diffs off for those urls, see:
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

## Use a custom Lighthouse configuration file

Tugboat uses the default Lighthouse configuration, but disables some server performance metrics. If you'd like to use a
custom Lighthouse configuration file, to tweak audit scoring or add custom checks, you can pass a custom Lighthouse
configuration object to use when generating reports.

You can find documentation for creating a custom Lighthouse config at:
[GoogleChrome/lighthouse blob on GitHub](https://github.com/GoogleChrome/lighthouse/blob/HEAD/docs/configuration.md).

```yaml
services:
  apache:
    urls:
      # Specify a custom config object to use to conduct Lighthouse audits
      config:
        --config-path=path/to/custom-config.js
      # Conduct Lighthouse audits of the these URLs using the custom config
      - /
      - /blog
      - /about
```

## Specify Lighthouse settings per-URL

You can also specify `lighthouse` configuration options on a per `url` basis. For more information, see:
[Tugboat Configuration -> urls](/reference/tugboat-configuration/#urls).

```yaml
services:
  apache:
    urls:
      # Create a Lighthouse report for the home page using the default options
      - url: /

      # Create a Lighthouse report for /blog, but override the default config with a custom config object
      - url: /blog
        lighthouse:
          config: --config-path=path/to/custom-config.js

      # Turn off Lighthouse reports for /about, but leave the URL in the list for other Service URL activities, such as generating visual diffs
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
      # Create Lighthouse reports for the default alias
      :default:
        - /
        - /blog

      # Create Lighthouse reports for the "foo" alias
      foo:
        - /
        - /about

      # This will be ignored because there is no matching "bar" service alias
      bar:
        - /
```

{{% notice tip %}} If you're not running an `apache` service on your Preview, but you _are_ running `php`, set up
Lighthouse under the `php` service. {{% /notice %}}
