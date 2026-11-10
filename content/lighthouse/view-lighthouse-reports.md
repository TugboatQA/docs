---
title: "View Lighthouse Reports"
date: 2020-09-23T15:30:03-04:00
weight: 2
---

When you configure Tugboat to generate Google Lighthouse reports for your web app or website, you'll see a Lighthouse
Reports status on your pull requests. To go directly to the Lighthouse reports in the Tugboat Preview Dashboard, click
the {{% ui-text %}}Details{{% /ui-text %}} link for the status. On GitHub, the {{% ui-text %}}Details{{% /ui-text %}}
link is in the {{% ui-text %}}…{{% /ui-text %}} menu next to the status.

![Screenshot showing a "Tugboat - Lighthouse Reports" passed status](/_images/lighthouse-reports-on-github-pr.png)

Alternately, to view Lighthouse reports from within Tugboat, here's how to get to the Preview Dashboard:

## To view Lighthouse reports:

1. Click into a Preview that has finished building.
2. Scroll down past the Services and you'll see the Lighthouse Reports pane.
3. Find the report for the URL you want. Each report lists the URL, the screen it ran against (Desktop or Mobile), and
   the scores for the Performance, Accessibility, Best Practices, and SEO categories.
4. Click one of the scores or the {{% ui-text %}}Details{{% /ui-text %}} button to expand the report. The expanded
   report shows a score graph for each category.
5. Click a score graph, or the {{% ui-text %}}Full Report{{% /ui-text %}} link, to open the full Lighthouse report in a
   new tab.

Inside the Lighthouse report, you'll see a list of audit items that were checked to provide your score. For more
information on what you'll see in Lighthouse reports, take a look at:
[Using Lighthouse -> What do Lighthouse reports measure?](../using-lighthouse/#what-do-lighthouse-reports-measure)

To view the reports for a single Service, click into the Service from the Preview Dashboard. The Service page has its
own Lighthouse Reports pane.

If you have defined thresholds for your reports, the pane also shows tabs and pass/fail status. Each report shows its
status in place of its scores, and failed or rejected reports open expanded. For more information, see:
[Use Lighthouse Thresholds](../use-lighthouse-thresholds/).

## Regenerate Lighthouse reports

You can regenerate a single report, or all of the reports for a Preview or Service. Tugboat asks you to confirm before
it regenerates.

### To regenerate a single report:

1. [View the Lighthouse reports](#to-view-lighthouse-reports) and expand the report.
2. Click the {{% ui-text %}}Regenerate{{% /ui-text %}} button.
3. In the dialog, click {{% ui-text %}}Regenerate{{% /ui-text %}} to confirm, or {{% ui-text %}}Cancel{{% /ui-text %}}
   to keep the current report.

### To regenerate all reports:

1. [View the Lighthouse reports](#to-view-lighthouse-reports).
2. Click the {{% ui-text %}}Regenerate All Reports{{% /ui-text %}} button on the Preview Dashboard, or the
   {{% ui-text %}}Regenerate All{{% /ui-text %}} button on a Service page.
3. In the dialog, click {{% ui-text %}}Regenerate{{% /ui-text %}} to confirm.

While Tugboat generates a report, you'll see {{% ui-text %}}Queued{{% /ui-text %}} and then
{{% ui-text %}}Generating{{% /ui-text %}} next to it. If Tugboat can't generate a report, the report shows the error
message and a {{% ui-text %}}Regenerate{{% /ui-text %}} button. If the reports don't have thresholds, a banner above the
reports shows how many failed to generate. To regenerate them all, click {{% ui-text %}}Regenerate
errored{{% /ui-text %}} in the banner. If the reports have thresholds, use the {{% ui-text %}}Error{{% /ui-text %}} tab
instead. See: [Regenerate reports by status](../use-lighthouse-thresholds/#regenerate-reports-by-status).

{{% notice info %}} While the Preview is building, you'll see: "Unavailable while preview is building" in the Lighthouse
Reports pane. After the Preview build has completed, the Lighthouse reports will generate. {{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Click into a Preview that has finished building;

![Click into Preview Dashboard](/_images/visual-diffs-click-into-preview.png)

Scroll down past the Services, and you'll see the Lighthouse Reports pane;

![View Lighthouse Reports Pane](/_images/lighthouse-reports-pane.png)

Click one of the scores or the {{% ui-text %}}Details{{% /ui-text %}} button to expand the report, then click the
{{% ui-text %}}Full Report{{% /ui-text %}} link to open the full Lighthouse report.

![Click into a Lighthouse audit category or view the full Lighthouse report](/_images/lighthouse-click-into-category-or-details.png)

Inside the Lighthouse report, you'll see a list of audit items that were checked to provide your score.

![Screenshot listing items checked in the Lighthouse performance audit](/_images/lighthouse-performance-report.png)

Click the {{% ui-text %}}Regenerate{{% /ui-text %}} button to regenerate a report, then confirm in the dialog.

![Regenerate Lighthouse reports](/_images/lighthouse-regenerate-reports.png)

{{% /expand%}}
