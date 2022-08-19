---
title: "Auto Share Preview URLs"
date: 2019-09-24T11:56:56-04:00
weight: 3
---

When you're using the Tugboat integration with [GitHub](/setting-up-tugboat/connect-with-your-provider/#github),
[GitLab](/setting-up-tugboat/connect-with-your-provider/#gitlab) or
[BitBucket](/setting-up-tugboat/connect-with-your-provider/#bitbucket), you can configure Tugboat to automatically post
links to Previews as comments on pull requests.

### To configure Tugboat to automatically post Preview links:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want Tugboat to auto-post Preview links.
3. Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.
4. Click the checkbox for {{% ui-text %}}Post Preview Links in Pull Request Comments{{% /ui-text %}} .
5. Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save your changes.

{{% notice note %}} By default, Tugboat's comments to a linked git provider display as the person who linked the
provider to Tugboat. That means the person who linked the repo will get notifications for every PR where Tugboat
automatically posts a comment. If this person does not wish to receive notifications, you can
[configure a Tugboat bot](/administer-tugboat-crew/add-tugboat-bot-to-team) to post the comments and receive those
notifications. {{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want Tugboat to auto-post Preview links.

![Select the project](/_images/select-a-project.png)

Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.

![Go to Repository Settings](/_images/go-to-repository-settings.png)

Click the checkbox for {{% ui-text %}}Post Preview Links in Pull Request Comments{{% /ui-text %}} .

![Click the checkbox next to Post Preview Links in Pull Request Comments](/_images/share-preview-post-preview-links-in-pull-request-comments.png)

Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save your changes.

![Press the Save Configuration button](/_images/share-preview-repo-settings-save-configuration.png)

{{% /expand%}}
