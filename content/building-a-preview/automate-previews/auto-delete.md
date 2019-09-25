---
title: "Auto-delete Previews"
date: 2019-09-24T11:49:57-04:00
weight: 5
---

Each of the Previews in your Tugboat project count toward the total storage
space available in your
[project's billing tier](/tugboat-billing/tugboat-pricing/). By default, Tugboat
is configured to automatically delete Previews when their corresponding git pull
requests are merged or closed.

### To automatically delete Previews:

If you want to change the setting to automatically delete Previews when their
PRs are merged or closed:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to configure auto-delete settings for
   Previews.
3. Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.
4. Click the checkbox to change the setting.
5. Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save
   your changes.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to configure auto-delete settings for
Previews.

![Select the project](/_images/select-a-project.png)

Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.

![Go to Repository Settings](/_images/go-to-repository-settings.png)

Click the checkbox to change the setting.

![Click the checkbox to turn auto-delete Preview on or off](/_images/auto-delete-preview-repository-settings.png)

Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save your
changes.

![Press the Save Configuration button](/_images/repository-settings-press-save-configuration.png)
