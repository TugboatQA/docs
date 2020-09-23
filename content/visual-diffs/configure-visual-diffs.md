---
title: "Configure Visual Diffs"
date: 2019-09-26T15:29:49-04:00
lastmod: 2020-09-22T17:00:00-04:00
weight: 1
---

- [Simple visualdiff configuration](#simple-visualdiff-copnfiguration)
- [Group visualdiffs via service alias](#group-visualdiffs-via-service-alias)
- [Use advanced visualdiff configuration options](#use-advanced-visualdiff-configuration-options)

## Simple visualdiff configuration

To configure which pages have Visual Diffs generated, specify the _relative URLs_ of the pages in a `urls` key in the
[service definition](/setting-up-services/). In this format, each URL can be a string, and you can list multiple urls.

```yaml
services:
  apache:
    web:
      urls:
        # Create visual diffs of the these URLs using the default options
        - /
        - /blog
        - /about
```

## Group visualdiffs via service alias

The URL list can also be grouped by [service alias](/reference/tugboat-configuration/#aliases), which is convenient when
aliases have different URL structures

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

      # This will be ignored because there is no matching "bar" service alias
      bar:
        - /
```

{{% notice tip %}} If you're not running an `apache` service on your Preview, but you _are_ running `php`, set up Visual
Diffs under the `php` service. {{% /notice %}}

## Use advanced visualdiff configuration options

You can also use advanced visualdiff configuration options to specify additional criteria for Tugboat to use when
generating visual diffs. When you want to specify configuration options beyond the default, you'll need to use an
additional `visualdiff` key under the `url` key to let Tugboat know that your instructions apply to visual diffing. For
more information on the configuration options available for visual diffs, see:
[Tugboat Configuration -> visualdiff](/reference/tugboat-configuration/#visualdiff).

```yaml
services:
  apache:
    web:
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
