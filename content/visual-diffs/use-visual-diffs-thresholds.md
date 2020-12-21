---
title: "Use Visual Diff Thresholds"
date: 2020-12-21T16:00:00-04:00
weight: 5
---

If you've defined a similarity threshold for visual diffs, Tugboat sets a "Pass" or "Fail" status on visual diffs where
that threshold is defined. That status displays in the Tugboat Dashboard, and it reports to the linked git provider -
for example, GitHub.

## View Visual Diff Thresholds in the Tugboat Dashboard

## View Visual Diff Thresholds in a linked git repository

Without a threshold, visual diffs show as a "Pass" in the linked git repository. This indicates that the visual diffs
successfully generated.

If you define a similarity threshold, visual diffs only show as a "Pass" if they generated successfully, and the visual
diffs meet or exceed your similarity threshold.

If you define a similarity threshold and the visual diffs don't meet it, you'll see the visual diffs as a fail in the
linked git repository.

Visual diffs also show as a fail in the linked git repository if they don't generate successfully.
