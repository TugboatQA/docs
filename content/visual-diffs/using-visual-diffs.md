---
title: "Using Visual Diffs"
date: 2019-09-19T10:32:20-04:00
weight: 4
---

When a Preview is built from a
[Base Preview](/building-a-preview/work-with-base-previews/set-a-base-preview/),
Tugboat can generate Visual Diff images to highlight any changes between the
Base Preview and the new Preview.

![Visual Diff Example](/_images/visualdiff.png)

Ready to get started with Visual Diffs? Here's what you need to know:

- [How to configure Visual Diffs](#how-to-configure-visual-diffs)
- [How to view Visual Diffs](#how-to-view-visual-diffs)
- [How are Visual Diffs calculated?](#how-are-visual-diffs-calculated)

## How to configure Visual Diffs

To configure which pages have Visual Diffs generated, specify the _relative
URLs_ of the pages in a `visualdiffs` key in the
[service definition](/setting-up-services/). Each URL can be either a string, or
a map that overrides the default screenshot options. For more info on exactly
what you can use in this key, check out:
[Service Attributes -> visualdiffs](/setting-up-services/reference/service-attributes/#visualdiffs).

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
[service alias](/setting-up-services/reference/service-attributes/#aliases),
which is convenient when aliases have different URL structures

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

{{% notice tip %}} If you're not running an `apache` service on your Preview,
but you _are_ running `php`, set up Visual Diffs under the `php` service.
{{% /notice %}}

## How to view Visual Diffs

To view Visual Diffs, you'll need to go to the Preview Dashboard.

1. Click into a Preview that has finished building.
2. Scroll down past the Preview Log and you'll see the Visual Diffs pane.
3. Click into the Visual Diff for Mobile, Tablet or Desktop to see the diff.

Inside the diff, you'll see a **Before** visualization on the left, an **After**
visualization on the right, and a composite in the middle, which highlights
changes to the page.

You'll also see an option to {{% ui-text %}}Regenerate{{% /ui-text %}} visual
diffs; use this if you've updated your Base Preview, and want to see a new
version of the visual diffs for this build.

{{% notice info %}} While the Preview is building, you'll see: "Unavailable
while preview is building" in the Visual Diffs pane. After the Preview build has
completed, it will take some time for visual diffs to generate. If you get an
error message, or don't see what you expect when the visual diffs generate, head
over to
[Troubleshooting -> Visual Diffs](/troubleshooting/preview-built-problem/#troubleshooting-visual-diffs)
for tips on figuring out what happened. {{% /notice %}}

### Visual Walkthrough

Click into a Preview that has finished building;

![Click into Preview Dashboard](/_images/visual-diffs-click-into-preview.png)

Scroll down past the Preview Log, and you'll see the Visual Diffs pane;

![View Visual Diffs Pane](/_images/visual-diffs-scroll-to-view-visual-diffs.png)

Click into the Visual Diff for **Mobile**, **Tablet** or **Desktop** to see the
diff.

![Click into the Visual Diff to see the diff](/_images/visual-diffs-click-into-mobile-to-view-diff.png)

Inside the diff, you'll see a **Before** visualization on the left, an **After**
visualization on the right, and a composite in the middle, which highlights
changes to the page.

![Visual Diff Before, After and Difference](/_images/visual-diffs-before-after-example.png)

You'll also see an option to {{% ui-text %}}Regenerate{{% /ui-text %}} visual
diffs; use this if you've updated your Base Preview, and want to see a new
version of the visual diffs for this build.

![Regenerate visual diffs](/_images/visual-diffs-regenerate.png)

## How are Visual Diffs calculated?

Tugboat's Visual Diffs implementation is a pixel-by-pixel comparison of what a
Preview page looks like. The percent calculation displayed next to the diff is a
literal calculation of how many pixels have changed in the page from Before to
After. This makes it a great tool for front-end developers to visually see what
has changed on the page, and it also helps Q/A, Product and UX spot new feature
implementation - and also regression bugs.

![Example Visual Diff with page contents moved down](/_images/visual-diffs-page-contents-moved-down.png)

As a result of the way Visual Diffs are calculated, though, when you move
something at the top of the page that bumps content down, the whole page may
show up as changed. This is because all of the pixels on the pixel-by-pixel
calculation are no longer an exact match; everything has shifted down. It's
great for visual regression testing, or spotting the introduction of new bugs,
but may make something like diffing content changes visually less meaningful.
