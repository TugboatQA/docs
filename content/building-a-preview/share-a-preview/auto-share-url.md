---
title: "Auto Share Preview URLs"
date: 2019-09-24T11:56:56-04:00
weight: 3
---

When you're using the Tugboat integration with
[GitHub](../../setting-up-tugboat/index.md#github),
[GitLab](../../setting-up-tugboat/index.md#gitlab) or
[BitBucket](../../setting-up-tugboat/index.md#bitbucket), you can configure
Tugboat to automatically post links to Previews as comments on pull requests.

## To configure Tugboat to automatically post Preview links:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want Tugboat to auto-post Preview links.
3. Click into **Settings** for the repository.
4. Click the checkbox for **Post Preview Links in Pull Request Comments**.
5. Press the Save Configuration button to save your changes.

{{% notice note %}} By default, Tugboat's comments to a linked git provider
display as the person who linked the provider to Tugboat. That means the person
who linked the repo will get notifications for every PR where Tugboat
automatically posts a comment. If this person does not wish to receive
notifications, you can
[configure a Tugboat bot](../../administering-tugboat-crew/index.md#add-a-tugboat-bot-to-your-team)
to post the comments and receive those notifications. {{% /notice %}}

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want Tugboat to auto-post Preview links.

![Select the project](/_images/select-a-project.png)

Click into **Settings** for the repository.

![Go to Repository Settings](/_images/go-to-repository-settings.png)

Click the checkbox for **Post Preview Links in Pull Request Comments**.

![Click the checkbox next to Post Preview Links in Pull Request Comments](/_images/share-preview-post-preview-links-in-pull-request-comments.png)

Press the Save Configuration button to save your changes.

![Press the Save Configuration button](/_images/share-preview-repo-settings-save-configuration.png)
