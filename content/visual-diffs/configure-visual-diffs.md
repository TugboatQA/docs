---
title: "Configure Visual Diffs"
date: 2019-09-26T15:29:49-04:00
lastmod: 2020-12-21T14:00:00-04:00
weight: 1
---

## Prerequisite: Use Base Previews

In order to configure Tugboat's visual diffs, you must be using at least one
[Base Preview](/building-a-preview/work-with-base-previews/). For more info, see:
[How Visual Diffs work](../using-visual-diffs/).

{{% notice tier %}} This feature is available for [Tugboat Plus and Premium plans](https://www.tugboat.qa/pricing). If
you'd like to run visual diffs on your Tugboat Previews, but you're on a different tier, you'll need to upgrade your
project.{{% /notice %}}

### How to configure visual diffs

- [Simple visualdiff configuration](#simple-visualdiff-configuration)
- [Group visualdiffs via service alias](#group-visualdiffs-via-service-alias)
- [Use advanced visualdiff configuration options](#use-advanced-visualdiff-configuration-options)
- [Specify screenshot and visualdiff settings explicitly](#specify-screenshot-and-visualdiff-settings-explictly)
- [Turn off visual diffs](#turn-off-visual-diffs)
- [Set thresholds for pass/fail](#set-thresholds-for-pass-fail)

## Simple visualdiff configuration

To configure which pages have Visual Diffs generated, specify the _relative URLs_ of the pages in a `urls` key in the
[service definition](/setting-up-services/). In this format, each URL can be a string, and you can list multiple urls.

```yaml
services:
  apache:
    urls:
      # Create visual diffs of the these URLs using the default options
      - /
      - /blog
      - /about
```

## Group visualdiffs via service alias

You can also group URLs by [service alias](/reference/tugboat-configuration/#aliases), which is convenient when aliases
have different URL structures.

```yaml
services:
  apache:
    aliases:
      - foo

    urls:
      # Create visualdiffs for the default alias
      :default:
        - /
        - /blog

      # Create visualdiffs for the "foo" alias
      foo:
        - /
        - /about
```

{{% notice tip %}} If you're not running an `apache` service on your Preview, but you _are_ running `php`, set up Visual
Diffs under the `php` service. {{% /notice %}}

## Use advanced visualdiff configuration options

You can also use advanced `visualdiff` configuration options to specify additional criteria for Tugboat to use when
generating visual diffs. When you want to specify configuration options beyond the default, you'll need to use an
additional `visualdiff` key.

You can set `visualdiff` options for all URLs in the list under the `urls` key, or under an individual `url` key to
apply the settings to a specific URL. For more information on the configuration options available for visual diffs, see:
[Tugboat Configuration -> visualdiff](/reference/tugboat-configuration/#visualdiff) and
[Tugboat Configuration -> urls](/reference/tugboat-configuration/#urls).

```yaml
services:
  apache:
    urls:
      # Create a visualdiff of the home page using the default options
      - url: /

      # Create a visualdiff of /blog, but override the default timeout option
      - url: /blog
        visualdiff:
          timeout: 10

      # Create a visualdiff of /about, but override the default waitUntil option
      - url: /about
        visualdiff:
          waitUntil: domcontentloaded
```

## Specify screenshot and visualdiff settings explicitly

Tugboat's visual diffs depend on an underlying `screenshot` functionality. Tugboat's `screenshot` engine uses
[Puppeteer](https://developers.google.com/web/tools/puppeteer) to take screenshots of URLs in your Tugboat Preview.

Tugboat's `config.yml` gives you the option to specify settings explicitly for both `screenshot` and `visualdiff`.

When you specify settings for `screenshot`, those configuration options determine the screenshots taken of the Preview
for which you're generating visual diffs.

When you specify settings for `visualdiff`, those configuration options determine the screenshots taken of the Base
Preview that Tugboat compares against to generate visual diffs.

For a full list of the configuration options you can use when setting both `screenshot` and `visualdiff` options, see:
[Tugboat Configuration -> screenshot](/reference/tugboat-configuration/#screenshot) and
[Tugboat Configuration -> visualdiff](/reference/tugboat-configuration/#visualdiff).

For example, explicitly setting both of these options in a `config.yml` might look something like this:

```yaml
services:
  apache:
    # Screenshot settings that affect all of the defined service URLs.
    # These override our defaults, and can also be overridden per-URL
    screenshot:
      enabled: true

      # The following options are used when taking a screenshot of
      # the URL for _this_ preview
      timeout: 30
      waitUntil:
        - load
      fullPage: true

    # Visual Diff settings that affect all of the defined service URLs.
    # These override our defaults, and can also be overridden per-URL
    visualdiff:
      # Visual Diffs depend on Screenshots being enabled. If Screenshots
      # are disabled for this Service, Visual Diffs are also disabled,
      # and this setting has no effect.
      enabled: true
      # The following options are used when taking a screenshot of
      # the URL for the _base_ preview
      timeout: 30
      waitUntil:
        - load
      fullPage: true
```

## Turn off visual diffs

By default, Tugboat's [URL configuration](/reference/tugboat-configuration/#urls) enables `screenshot`, `visualdiff`,
_and_ `lighthouse` functionality. If you only want to view Lighthouse audits for a URL or group of URLs, but want to
explicitly turn visual diffs off for one or all pages, you can do that by setting `enabled: false`. In a `config.yml`,
this might look like:

```yaml
services:
  apache:
    # Turn off screenshots for all of the defined service URLs.
    # Visual Diffs depend on Screenshots being enabled. If Screenshots
    # are disabled for this Service, Visual Diffs are also disabled.
    # This overrides our defaults, and can also be overridden per-URL
    screenshot:
      enabled: false

    urls:
      # Lighthouse reports will be generated for all URLs. However,
      # with screenshot disabled at the Service level, these pages will
      # not generate visual diffs.
      - /
      - /about
      # Create a visual diff of /blog, overriding the Service-level
      # disabling of screenshots & visual diffs
      - url: /blog
        screenshot:
          enabled: true
        visualdiff:
          enabled: true
```

## Set thresholds for pass/fail

If you'd like to specify a pass/fail threshold for visual diffs, you can define a similarity threshold in your Tugboat
config. If the visual diff meets or exceeds your similarity threshold, it sets a "Pass" status; if it does not meet your
similarity threshold, the visual diff will register as a "Fail."

To set the similarity threshold for visual diffs:

```yaml
services:
  apache:
    urls:
      # Create a visualdiff of the home page using the default options
      - url: /

      # Create a visualdiff of /blog, but set a similarity threshold of 90%
      - url: /blog
        visualdiff:
          threshold: 90

      # Create a visualdiff of /about, but specify different similarity thresholds depending on the breakpoint
      - url: /about
        visualdiff:
          threshold:
            desktop: 90
            mobile: 80
            tablet: 99
```
