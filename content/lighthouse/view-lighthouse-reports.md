---
title: "View Lighthouse Reports"
date: 2020-09-23T15:30:03-04:00
weight: 2
---

When you configure Tugboat to generate Google Lighthouse reports for your web app or website, you'll see a Lighthouse
Reports status on your pull requests. You can click the **Details** link to go directly to the Lighthouse reports in the
Tugboat Preview Dashboard.

![Screenshot showing a "Tugboat - Lighthouse Reports" passed status](/_images/lighthouse-reports-on-github-pr.png)

Alternately, to view Lighthouse reports from within Tugboat, here's how to get to the Preview Dashboard:

## To view Lighthouse reports:

1. Click into a Preview that has finished building.
2. Scroll down past the Services and you'll see the Lighthouse Reports pane.
3. Click into one of the numbers to view the specifics for that category's audit, or click the Details link to view the
   full Lighthouse report.

Inside the Lighthouse report, you'll see a list of audit items that were checked to provide your score. For more
information on what you'll see in Lighthouse reports, take a look at:
[Using Lighthouse -> What do Lighthouse reports measure?](../using-lighthouse/#what-do-lighthouse-reports-measure)

You'll also see an option to {{% ui-text %}}Regenerate{{% /ui-text %}} Lighthouse reports.

{{% notice info %}} While the Preview is building, you'll see: "Unavailable while preview is building" in the Lighthouse
Reports pane. After the Preview build has completed, the Lighthouse reports will generate. {{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Click into a Preview that has finished building;

![Click into Preview Dashboard](/_images/visual-diffs-click-into-preview.png)

Scroll down past the Services, and you'll see the Lighthouse Reports pane;

![View Lighthouse Reports Pane](/_images/lighthouse-reports-pane.png)

Click into one of the numbers to view the specifics for that category's audit, or click the Details link to view the
full Lighthouse report.

![Click into a Lighthouse audit category or view the full Lighthouse report](/_images/lighthouse-click-into-category-or-details.png)

Inside the Lighthouse report, you'll see a list of audit items that were checked to provide your score.

![Screenshot listing items checked in the Lighthouse performance audit](/_images/lighthouse-performance-report.png)

You'll also see an option to {{% ui-text %}}Regenerate{{% /ui-text %}} Lighthouse reports.

![Regenerate Lighthouse reports](/_images/lighthouse-regenerate-reports.png)

{{% /expand%}}
