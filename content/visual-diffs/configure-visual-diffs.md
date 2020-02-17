---
title: "Configure Visual Diffs"
date: 2019-09-26T15:29:49-04:00
weight: 1
---

To configure which pages have Visual Diffs generated, specify the _relative URLs_ of the pages in a `visualdiffs` key in
the [service definition](/setting-up-services/). Each URL can be either a string, or a map that overrides the default
screenshot options. For more info on exactly what you can use in this key, check out:
[Tugboat Configuration -> visualdiffs](/reference/tugboat-configuration/#visualdiffs).

```yaml
services:
  apache:
    visualdiffs:
      # Create a visualdiff of the home page using the default options
      - /

      # Create a visualdiff of /blog, but override the default timeout option
      - url: /blog
        timeout: 10

      # Create a visualdiff of /about, but override the default waitUntil option
      - url: /about
        waitUntil: domcontentloaded
```

The URL list can also be grouped by [service alias](/reference/tugboat-configuration/#aliases), which is convenient when
aliases have different URL structures

```yaml
services:
  apache:
    aliases:
      - foo

    visualdiffs:
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
