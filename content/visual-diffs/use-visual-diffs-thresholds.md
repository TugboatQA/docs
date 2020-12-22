---
title: "Use Visual Diff Thresholds"
date: 2020-12-21T16:00:00-04:00
weight: 5
---

If you've defined a similarity threshold for visual diffs, Tugboat sets a "Pass" or "Fail" status on visual diffs where
that threshold is defined. That status displays in the Tugboat Dashboard, and it reports to the linked git provider -
for example, GitHub.

You may want to do a few things with visual diff thresholds:

- [View pass/fail results in a linked git repository](#view-visual-diff-pass-fail-results-in-a-linked-git-repository)
- [View pass/fail results in the Tugboat Dashboard](#view-visual-diff-pass-fail-results-in-the-tugboat-dashboard)
- [Approve or Decline visual diffs](#approve-or-decline-visual-diffs)
- [Re-run visual diff similarity calculations](#re-run-visual-diff-similarity-calculations)

If you're looking for documentation on how to configure visual diff thresholds, see:
[Configure Visual Diffs -> Set thresholds for pass/fail](../configure-visual-diffs/#set-thresholds-for-pass-fail)

## View visual diff pass/fail results in a linked git repository

### Pass results in a linked git repository

When you [define a similarity threshold](../configure-visual-diffs/#set-thresholds-for-pass-fail), visual diffs show as
a "Pass" in the linked git provider if they generated successfully, and the visual diffs meet or exceed your similarity
threshold.

![Screenshot of GitHub status showing a green checkmark on Tugboat - Visual Diffs](/_images/visual-diffs-pass-status-in-github.png)

{{% notice info %}} When you don't define a similarity threshold, successfully generating visual diffs shows as a "Pass"
in the linked git repository. In this case, the "Pass" status doesn't indicate anything about the results of the visual
diffs - only that they've been created. {{% /notice %}}

### Fail results in a linked git repository

If you define a similarity threshold and the visual diffs don't meet it, you'll see the visual diffs as a fail in the
linked git repository.

![Screenshot of GitHub status showing a red X on Tugboat - Visual Diffs](/_images/visual-diffs-fail-status-in-github.png)

{{% notice info %}} When you don't define a similarity threshold, visual diffs shows as a "Fail" in the linked git
repository when they don't generate successfully. In this case, the "Fail" status doesn't indicate anything about the
results of the visual diffs - only that the process failed and needs to be debugged. {{% /notice %}}

### View visual diff results from a linked git repository

If you want to view the visual diff results, you can click the {{% ui-text %}}Details{{% /ui-text %}} link to go
directly to the visual diffs in the Tugboat Dashboard.

![Screenshot of GitHub status showing a red X on Tugboat - Visual Diffs](/_images/visual-diffs-view-details-from-github.png)

## View visual diff pass/fail results in the Tugboat Dashboard

There are two ways to view the visual diff results:

1. [Click the {{% ui-text %}}Details{{% /ui-text %}} link from the pull request in the git repository.](#view-visual-diff-results-from-a-linked-git-repository)
2. [View visual diffs from within the Tugboat Dashboard.](../view-visual-diffs/)

In this view, you'll see a list of all the visual diffs that have been defined for the Preview at various breakpoints
(Desktop, Tablet, Mobile), along with a similarity percentage for each visual diff.

If you have defined a threshold, and that threshold is not met, you'll see an X and a message that the diff is "Less
than {Your Threshold} similar", indicating the visual diff is currently in a "failed" status.

![Screenshot of visual diff table view showing a gold "Fail" X on diffs that do not meet the similarity threshold](/_images/visual-diffs-do-not-meet-similarity-threshold.png)

From here, you can click into the screenshot at each breakpoint to view the visual diff for that breakpoint.

![Screenshot of failed visual diff results showing Before, After, and pixel-by-pixel similarity comparison](/_images/view-failed-visual-diff.png)

## Approve or Decline visual diffs

When you have clicked into a screenshot at a specific breakpoint to view the visual diff for that breakpoint, you can
manually change the visual diff status to {{% ui-text %}}Approve{{% /ui-text %}} or
{{% ui-text %}}Decline{{% /ui-text %}}. You might want to do this to block or unblock merging the pull request.

If you set **all** visual diffs to {{% ui-text %}}Approve{{% /ui-text %}}, the visual diff status in the linked git
repository will change to a "Pass". This will unblock merging a pull request. You might want to do this if all of the
changes on the page are expected given the work in the pull request, even though the changes fall outside the normal
visual diff similarity threshold.

If you set _any_ visual diff to {{% ui-text %}}Decline{{% /ui-text %}}, the visual diff status in the linked git
repository will show as a "Fail." Depending on the repository settings, this may block merging a pull request. You might
want to do this if you spot a change in a visual diff that represents a bug or requires developer rework.

### To approve or decline a visual diff:

1. [Follow our instructions to view visual diffs](../view-visual-diffs/), clicking into the breakpoint where you want to
   change the Pass/Fail status.
2. Click the {{% ui-text %}}Approve{{% /ui-text %}} or {{% ui-text %}}Decline{{% /ui-text %}} link.

![Screenshot of failed visual diff results with an arrow pointing to the Approve link](/_images/manually-approve-a-visual-diff.png)

You'll see the visual diff results change to a message saying: "This visual diff has been approved."

![Screenshot of manually approved visual diff results](/_images/visual-diff-has-been-approved.png)

Once **all** of the visual diffs are approved, you'll see visual diffs in a linked git repository change to a "Pass"
status. Alternately, once _any_ visual diff is declined, you'll see visual diffs in a linked git repository change to a
"Fail" status.

![Screenshot of GitHub status showing a green checkmark on Tugboat - Visual Diffs](/_images/visual-diffs-pass-status-in-github.png)

## Re-run visual diff similarity calculations

Use the {{% ui-text %}}Regenerate{{% /ui-text %}} option to generate a new set of visual diffs, and re-run the visual
diff similarity calculation. You can regenerate a single visual diff, or an entire set of them.

### To regenerate a single visual diff:

1. [Follow our instructions to view visual diffs](../view-visual-diffs/), clicking into the breakpoint where you want to
   re-run the similarity calculation.
2. Click the {{% ui-text %}}Regenerate{{% /ui-text %}} link.

![Screenshot of failed visual diff results with an arrow pointing to the Regenerate link](/_images/visual-diffs-regenerate-single.png)

### To regenerate a set of visual diffs:

1. Click into a Preview that has finished building.
2. Scroll down past the Services and Lighthouse Reports, and you’ll see the Visual Diffs pane.
3. Click the {{% ui-text %}}Regenerate{{% /ui-text %}} link.

{{%expand "Visual Walkthrough" %}}

Click into a Preview that has finished building;

![Click into Preview Dashboard](/_images/visual-diffs-click-into-preview.png)

Scroll down past the Services and Lighthouse Reports, and you'll see the Visual Diffs pane;

![View Visual Diffs Pane](/_images/visual-diffs-scroll-to-view-visual-diffs.png)

Click the {{% ui-text %}}Regenerate{{% /ui-text %}} link.

![Regenerate visual diffs](/_images/visual-diffs-regenerate.png)

{{% /expand%}}
