---
title: "Use Lighthouse Thresholds"
date: 2026-11-09T09:00:00-05:00
weight: 3
---

A threshold is the minimum score that a Lighthouse report category must reach. A tolerance is the number of points a
score can fall below its threshold and still pass. Tugboat compares each report to its thresholds and sets a "Pass" or
"Fail" status on the report. That status displays in the Tugboat Dashboard, and it reports to the linked git provider,
for example GitHub.

Lighthouse scores can vary between runs of the same page, even when the page doesn't change. Performance scores vary the
most, because Tugboat runs Lighthouse on shared infrastructure. With a tolerance of zero, a small variation can fail a
report. For example, with a threshold of `base`, a performance score of 89 fails when the Base Preview scored 90. A
tolerance of a few points lets those small variations pass, and still fails a report whose score drops further.

{{% notice tier %}} This feature is available for
[Tugboat Premium plans](https://www.tugboatqa.com/premium).{{% /notice %}}

You may want to do a few things with Lighthouse thresholds:

- [Compare reports to the Base Preview](#compare-reports-to-the-base-preview)
- [Set thresholds in `config.yml`](#set-thresholds-in-configyml)
- [Set thresholds with the CLI](#set-thresholds-with-the-cli)
- [View pass/fail results in a linked git repository](#view-passfail-results-in-a-linked-git-repository)
- [View pass/fail results in the Tugboat Dashboard](#view-passfail-results-in-the-tugboat-dashboard)
- [Approve or reject Lighthouse reports](#approve-or-reject-lighthouse-reports)
- [Regenerate reports by status](#regenerate-reports-by-status)

## Compare reports to the Base Preview

When a Preview is built from a [Base Preview](/building-a-preview/work-with-base-previews/), Tugboat uses the scores of
the matching report in the Base Preview as the thresholds for each report that doesn't have thresholds in your
[`config.yml`](#set-thresholds-in-configyml), with a tolerance of zero. A matching report has the same Service, URL,
alias, and screen. If the Base Preview doesn't have a matching report, Tugboat generates one first.

To use this comparison, [configure Lighthouse](../configure-lighthouse/) and
[set a Base Preview](/building-a-preview/work-with-base-previews/set-a-base-preview/).

## Set thresholds in `config.yml`

To set thresholds for the reports generated from the `urls` in your `config.yml`, add a `threshold` key to a
`lighthouse` block. A `threshold` in the Service-level [`lighthouse`](/reference/tugboat-configuration/#lighthouse)
block applies to every URL of the Service. A `threshold` in the `lighthouse` block of a single
[URL](/reference/tugboat-configuration/#urls) applies to that URL.

A threshold is a score from 0 to 100, or `base` to use the score of the matching report in the Base Preview, as
described in [Compare reports to the Base Preview](#compare-reports-to-the-base-preview). The categories are
`performance`, `accessibility`, `best-practices`, and `seo`.

To use the same threshold for every category, set `threshold` to a number:

```yaml
services:
  apache:
    lighthouse:
      threshold: 90
    urls:
      - /
      - /blog
```

To set a tolerance, set `threshold` to an object with `threshold` and `tolerance` keys. The `threshold` key defaults to
`base`, and the `tolerance` key defaults to zero:

```yaml
services:
  apache:
    lighthouse:
      threshold:
        threshold: 90
        tolerance: 5
    urls:
      - /
```

{{% notice info %}} Put `tolerance` inside the `threshold` object. Tugboat ignores a `tolerance` key at the same level
as `threshold`. {{% /notice %}}

To set a threshold for individual categories, set `threshold` to a list. Tugboat doesn't check categories that you leave
out. Each item is a category name, which compares that category to the Base Preview, or an object with a `category` key
and optional `threshold` and `tolerance` keys:

```yaml
services:
  apache:
    lighthouse:
      threshold:
        # Performance must score at least 85, with a tolerance of 3 points
        - category: performance
          threshold: 85
          tolerance: 3
        # Accessibility must score at least 95
        - category: accessibility
          threshold: 95
        # SEO compares to the Base Preview
        - seo
    urls:
      - /
```

### Set thresholds for each screen

A number, `base`, object, or list applies to both the `desktop` and `mobile` screens. To set each screen separately, use
`desktop` and `mobile` keys. Each key accepts any of the forms above. When `threshold` has a `desktop` or `mobile` key,
it can't have any other keys. On a Service, a screen that you leave out compares every category to the Base Preview. On
a URL, a screen that you leave out keeps the Service-level threshold, as described in
[Override Service thresholds for a URL](#override-service-thresholds-for-a-url).

```yaml
services:
  apache:
    lighthouse:
      screen:
        - desktop
        - mobile
      threshold:
        desktop:
          threshold: 90
          tolerance: 2
        mobile: base
    urls:
      - /
```

Tugboat generates reports only for the screens in the `screen` list, which defaults to `desktop`. A threshold for a
screen that isn't in the list has no effect.

### Override Service thresholds for a URL

A `threshold` on a URL overrides the Service-level `threshold` only for the screens that it sets. The other screens keep
the Service-level threshold.

```yaml
services:
  apache:
    lighthouse:
      screen:
        - desktop
        - mobile
      threshold: 90
    urls:
      # Desktop and mobile use the Service threshold of 90
      - /
      # Desktop and mobile compare to the Base Preview
      - url: /blog
        lighthouse:
          threshold: base
      # Desktop compares to the Base Preview, and mobile keeps the Service threshold of 90
      - url: /about
        lighthouse:
          threshold:
            desktop: base
```

### Invalid thresholds

When a `threshold` is invalid, the Preview fails to build with error `1056`, `Invalid Preview configuration`. For more
information, see [Tugboat Error Codes](/reference/tugboat-error-codes/). These values are invalid:

- A score or tolerance outside 0 to 100
- An unknown category name
- An empty list, or a list item without a category
- A `desktop` or `mobile` key next to any other key, such as `tablet` or `threshold`

## Set thresholds with the CLI

Use the [Tugboat CLI](/tugboat-cli/) to set thresholds on a single report. A threshold is a score from 0 to 100, or
`base` to use the score of a base report. The categories are `performance`, `accessibility`, `best-practices`, and
`seo`.

The default tolerance is zero.

{{% notice info %}} Thresholds that you set with the CLI last until the Preview builds, rebuilds, or refreshes. When it
does, Tugboat sets the reports generated from the `urls` in your `config.yml` back to the thresholds in your
[`config.yml`](#set-thresholds-in-configyml), and deletes any other reports you created with
`tugboat create lighthouse`. A report without a threshold in your `config.yml` goes back to comparing against the Base
Preview, with a tolerance of zero. {{% /notice %}}

By default, Tugboat compares a report you create with the CLI to the matching report in the Base Preview, as described
in [Compare reports to the Base Preview](#compare-reports-to-the-base-preview). To create a report with the default
comparison, where `[service_id]` is the ID of a Service:

```sh
tugboat create lighthouse [service_id]
```

The report uses the URL `/` unless you pass `url`. If a report already exists for that URL and screen, for example one
generated from the `urls` in your `config.yml`, Tugboat updates that report instead of creating a new one.

To compare against a specific report instead of the matching Base Preview report, pass its ID as `base`:

```sh
tugboat create lighthouse [service_id] base=[base_report_id]
```

To use a fixed score instead of a base report, set `threshold` to a number. For example, to create a report with a
threshold of 85 for every category:

```sh
tugboat create lighthouse [service_id] threshold=85
```

To set a threshold for individual categories, specify each category you want to check. Tugboat doesn't check categories
that you leave out. Each category accepts a number or `base`:

```sh
tugboat create lighthouse [service_id] threshold.performance=85 threshold.seo=base tolerance.seo=3
```

To change the thresholds of an existing report, use `tugboat update`:

```sh
tugboat update [lighthouse_id] threshold=91 tolerance=2
```

To view the scores of a report, and the thresholds, tolerances, and approval status of a report that has a base report:

```sh
tugboat ls [lighthouse_id] --verbose
```

For a report without a base report, such as one with a fixed `threshold`, use `--json` to see its thresholds:

```sh
tugboat ls [lighthouse_id] --json
```

## View pass/fail results in a linked git repository

When the {{% ui-text %}}Set Pull Request status{{% /ui-text %}} setting is on for the
[git provider](/setting-up-tugboat/connect-with-your-provider/), Tugboat reports a `Tugboat - Lighthouse Reports` status
on pull requests and merge requests. The status shows as a "Pass" when every report in the Preview meets one of these
conditions:

- The report meets its thresholds, within its tolerance.
- The report has no thresholds.
- You approved the report.

The status shows as a "Fail" when any report doesn't meet its thresholds and isn't approved, or when you reject it. The
status shows as running while Tugboat generates reports.

![Screenshot of GitHub status showing a red X on Tugboat - Lighthouse Reports](/_images/lighthouse-thresholds-failed-github.png)

To go directly to the Lighthouse reports in the Tugboat Dashboard, click the {{% ui-text %}}Details{{% /ui-text %}} link
for the status. On GitHub, the {{% ui-text %}}Details{{% /ui-text %}} link is in the {{% ui-text %}}…{{% /ui-text %}}
menu next to the status.

## View pass/fail results in the Tugboat Dashboard

To view the results, [view the Lighthouse reports](../view-lighthouse-reports/) for a Preview or a Service. When a
report has thresholds, the reports for each Service show these tabs, with the number of reports in each:

- {{% ui-text %}}Failed{{% /ui-text %}}: Reports that don't meet their thresholds, and rejected reports. This tab is
  selected by default.
- {{% ui-text %}}Passed{{% /ui-text %}}: Reports that meet their thresholds, and approved reports.
- {{% ui-text %}}All{{% /ui-text %}}: All reports.
- {{% ui-text %}}Error{{% /ui-text %}}: Reports that Tugboat couldn't generate. This tab appears only when at least one
  report has an error.

![Screenshot of the Error tab showing a Lighthouse report that Tugboat couldn't generate](/_images/lighthouse-error.png)

Each score graph shows a target, which is the threshold minus the tolerance. Each report also shows a status message,
for example "Report meets all thresholds" or "Report does not meet the required goal for performance."

![Screenshot of a failed Lighthouse report showing the target for each category and the Approve button](/_images/lighthouse-thresholds-failed.png)

## Approve or reject Lighthouse reports

Approving or rejecting a report overrides its threshold result, in the Tugboat Dashboard and in the git provider status.
The approval or rejection lasts until the report regenerates. Regenerating a report, or building, rebuilding, or
refreshing the Preview, clears it.

### To approve or reject a Lighthouse report:

1. [View the Lighthouse reports](../view-lighthouse-reports/) and expand the report.
2. Click the {{% ui-text %}}Approve{{% /ui-text %}} button on a failed or rejected report, or the
   {{% ui-text %}}Reject{{% /ui-text %}} button on a passed or approved report.

You can also approve or reject a report with the CLI:

```sh
tugboat update [lighthouse_id] approved=true
tugboat update [lighthouse_id] approved=false
```

## Regenerate reports by status

Each tab has a button that regenerates only the reports in that tab, for example {{% ui-text %}}Regenerate All [Service]
Failed Reports{{% /ui-text %}} or {{% ui-text %}}Regenerate All [Service] Passing Reports{{% /ui-text %}}. On a Service
page, use the {{% ui-text %}}Regenerate All{{% /ui-text %}} button for the {{% ui-text %}}All{{% /ui-text %}} tab.
Tugboat asks you to confirm before it regenerates.

To regenerate by status with the CLI, pass the ID of a Service or Preview and set `status` to `passed`, `failed`,
`errored`, `approved`, or `rejected`:

```sh
tugboat rebuild lighthouse [service_id] status=failed
```
