---
title: "GitLab Pipeline Status is Wrong"
date: 2026-01-07T10:00:00-05:00
weight: 6
---

If you have more than one pipeline job for the same commit, like `Tugboat`, `Tugboat - Visual Diffs`, and
`Tugboat - Lighthouse`, sometimes the status of these pipelines in GitLab may not match the status in your Tugboat
Dashboard.

## What is going on?

When a merge request is opened or a push occurs, a preview build is triggered via a webhook. Tugboat then uses the
GitLab API to send commit status updates for the preview. These updates are known as **external commit statuses** and
appear in GitLab as the `Tugboat`, `Tugboat - Visual Diffs`, and `Tugboat - Lighthouse`, jobs under the external stage.

According to the
[GitLab documentation on external commit statuses](https://docs.gitlab.com/ci/ci_cd_for_external_repos/external_commit_statuses/),
when an external system (such as Tugboat) posts status updates, GitLab tries to find the most recent non-archived
pipeline for that commit and append the status to it. However, the documentation also states:

> When duplicate pipelines exist for the same commit, external status placement becomes ambiguous. GitLab selects the
> latest pipeline using `newest_first`, but with concurrent pipeline creation, this can lead to external statuses
> appearing in unexpected pipelines or becoming invisible in merge request views.

Because of this, a Tugboat customer can end up in situations where:

- The commit status doesn’t appear at all, even though it was sent.
- An older commit pipeline shows the Tugboat status as passed.
- The newest commit pipeline has no Tugboat status at all.

## How do I fix it?

We are investigating and gathering information about this scenario.
[Reach out to our support team](https://www.tugboatqa.com/support) if you are encountering this problem and would like
to share information about when this is occuring for you.
