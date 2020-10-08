---
title: "View Visual Diffs"
date: 2019-09-26T15:30:03-04:00
weight: 2
---

To view Visual Diffs, you'll need to go to the Preview Dashboard.

## To view Visual Diffs:

1. Click into a Preview that has finished building.
2. Scroll down past the Services and Lighthouse Reports, and you'll see the Visual Diffs pane.
3. Click into the Visual Diff for Mobile, Tablet or Desktop to see the diff.

Inside the diff, you'll see a **Before** visualization on the left, an **After** visualization on the right, and a
composite in the middle, which highlights changes to the page.

You'll also see an option to {{% ui-text %}}Regenerate{{% /ui-text %}} visual diffs; use this if you've updated your
Base Preview, and want to see a new version of the visual diffs for this build.

{{% notice info %}} While the Preview is building, you'll see: "Unavailable while preview is building" in the Visual
Diffs pane. After the Preview build has completed, it will take some time for visual diffs to generate. If you get an
error message, or don't see what you expect when the visual diffs generate, head over to
[Troubleshooting -> Visual Diffs](/troubleshooting/preview-built-problem/#troubleshooting-visual-diffs) for tips on
figuring out what happened. {{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Click into a Preview that has finished building;

![Click into Preview Dashboard](/_images/visual-diffs-click-into-preview.png)

Scroll down past the Services and Lighthouse Reports, and you'll see the Visual Diffs pane;

![View Visual Diffs Pane](/_images/visual-diffs-scroll-to-view-visual-diffs.png)

Click into the Visual Diff for **Mobile**, **Tablet** or **Desktop** to see the diff.

![Click into the Visual Diff to see the diff](/_images/visual-diffs-click-into-mobile-to-view-diff.png)

Inside the diff, you'll see a **Before** visualization on the left, an **After** visualization on the right, and a
composite in the middle, which highlights changes to the page.

![Visual Diff Before, After and Difference](/_images/visual-diffs-before-after-example.png)

You'll also see an option to {{% ui-text %}}Regenerate{{% /ui-text %}} visual diffs; use this if you've updated your
Base Preview, and want to see a new version of the visual diffs for this build.

![Regenerate visual diffs](/_images/visual-diffs-regenerate.png)

{{% /expand%}}
