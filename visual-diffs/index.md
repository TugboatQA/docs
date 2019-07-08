# Using Visual Diffs

When a preview is created from a base preview, Tugboat can generate visual diff
images to highlight any changes between the base preview and the new preview.

![Visual Diff Example](_images/visualdiff.png)

To configure which pages have visual diffs generated, specify the _relative
URLs_ of the pages in a `visualdiffs` key in the service definition. Each URL
can be either a string, or a map that overrides the default screenshot options

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

The URL list can also be grouped by
[service alias](../reference/tugboat-configuration/index.md#aliases), which is
convenient when aliases have different URL structures

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
