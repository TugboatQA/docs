---
title: "Change or Update a Base Preview"
date: 2019-09-24T11:52:38-04:00
weight: 3
---

There are a few different ways you can change or update your Base Previews:

- [Change a Base Preview](#change-a-base-preview)
- [Update a Base Preview](#update-a-base-preview)

## Change a Base Preview

If you want to change a Docker image that a Base Preview is using, or make
changes to something that happens during the `init` phase of the Preview build
process, you'll need to Rebuild your Base Preview. Rebuilding a Base Preview
kicks off a fresh build process from the beginning, in effect replacing your
current Base Preview with a new one that contains all of your changes.

Want to know more about build phases? Check out:
[the build process: explained](../../preview-deep-dive/how-previews-work/#the-build-process-explained).

{{% notice note %}} If you've checked the
[Repository Setting](/setting-up-tugboat/select-repo-settings/) to
{{% ui-text %}}Rebuild Orphaned Previews Automatically{{% /ui-text %}}, a
successful Rebuild of a Base Preview will kick off Rebuilds of any child
Previews that were built from your Base Preview. {{% /notice %}}

### To Rebuild a Base Preview:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to change the Base Preview.
3. Click the name of the repo that contains Base Preview you want to change.
4. Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for the Base
   Preview, and select {{% ui-text %}}Rebuild{{% /ui-text %}}.
5. To confirm that you actually want to change the Base Preview, rather than
   just updating it, click the checkbox next to {{% ui-text %}}Yes, rebuild this
   preview{{% /ui-text %}}. You may also want to {{% ui-text %}}Rebuild previews
   built from this one when finished{{% /ui-text %}}.
6. Press the {{% ui-text %}}Rebuild{{% /ui-text %}} button.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to change the Base Preview.

![Select the project](/_images/select-a-project.png)

Click the name of the repo that contains Base Preview you want to change.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for the Base
Preview, and select {{% ui-text %}}Rebuild{{% /ui-text %}}.

![Click the Actions drop-down, and select Rebuild.](/_images/base-preview-actions-rebuild.png)

To confirm that you actually want to change the Base Preview, rather than just
updating it, click the checkbox next to {{% ui-text %}}Yes, rebuild this
preview{{% /ui-text %}}. You may also want to {{% ui-text %}}Rebuild previews
built from this one when finished{{% /ui-text %}}.

![Confirm Rebuild Previews built from this Base Preview after Rebuild](/_images/base-preview-rebuild-previews-from-base-after-rebuild.png)

Press the {{% ui-text %}}Rebuild{{% /ui-text %}} button.

![Press the Rebuild button](/_images/base-preview-press-rebuild-button.png)

{{% /expand%}}

## Update a Base Preview

If you don't need to pull a new Docker image or make changes to the `init` phase
in your [config file](/setting-up-tugboat/create-a-tugboat-config-file/), you
can do a smaller, faster update of your Base Preview using Refresh. Refreshing a
Base Preview:

1. Pulls the latest code from git.
2. Runs commands from the `update` section of the config.yml.
3. Run commands from the `build` section of the config.yml.

Want to know more about build phases? Check out:
[the build process: explained](../../preview-deep-dive/how-previews-work/#the-build-process-explained).

{{% notice tip %}} If you want to pull a fresh Docker image, or if you've made
changes to the config.yml's `init` phase, you'll need to
[rebuild the Base Preview](#change-a-base-preview) in order to see those
changes. {{% /notice %}}

Tugboat provides a couple of ways to Refresh a Base Preview:

- [Manually Refresh a Base Preview](#manually-refresh-a-base-preview)
- [Automatically Refresh Base Previews](#automatically-refresh-a-base-preview)

{{% notice note %}} If you've checked the
[Repository Setting](/setting-up-tugboat/select-repo-settings/) to
{{% ui-text %}}Rebuild Stale Previews Automatically{{% /ui-text %}}, a
successful Refresh of a Base Preview will kick off Rebuilds of any child
Previews that were built from your Base Preview. {{% /notice %}}

### Manually Refresh a Base Preview

To manually kick off a Base Preview update:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to update the Base Preview.
3. Click the name of the repo that contains Base Preview you want to update.
4. Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for the Base
   Preview, and select {{% ui-text %}}Refresh{{% /ui-text %}}.
5. If you want to
   [Rebuild Previews that were built from this Base Preview](../building-new-previews/)
   after the update, click the checkbox next to {{% ui-text %}}Rebuild Previews
   built from this one when finished{{% /ui-text %}}.
6. Press the {{% ui-text %}}Refresh{{% /ui-text %}} button.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to update the Base Preview.

![Select the project](/_images/select-a-project.png)

Click the name of the repo that contains Base Preview you want to update.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for the Base
Preview, and select {{% ui-text %}}Refresh{{% /ui-text %}}.

![Click the Actions drop-down, and select Refresh.](/_images/base-preview-actions-refresh.png)

If you want to
[Rebuild Previews that were built from this Base Preview](../building-new-previews/)
after the update, click the checkbox next to {{% ui-text %}}Rebuild Previews
built from this one when finished{{% /ui-text %}}.

![Confirm Rebuild Previews built from this Base Preview after Refresh](/_images/base-preview-rebuild-previews-from-base-after-refresh.png)

Press the {{% ui-text %}}Refresh{{% /ui-text %}} button.

![Press the Refresh button](/_images/base-preview-press-refresh-button.png)

{{% /expand%}}

### Automatically Refresh a Base Preview

You'll generally want to keep your Base Preview up to date with your latest
codebase, and a fresh copy of your database, image files, and other assets. By
default, Tugboat automatically checks for updates every night at 12 am UTC, and
refreshes your Base Preview with these updates. You can toggle this feature, or
change the time and interval at which Tugboat does an automated Refresh of your
Base Previews.

To change Tugboat's settings to automatically Refresh Base Previews:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to configure auto-update settings for Base
   Previews.
3. Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.
4. Go to {{% ui-text %}}Refresh Base Previews Automatically{{% /ui-text %}}.
   Toggle the checkbox and/or adjust the frequency and timing of these automatic
   updates.
5. Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save
   your changes.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to configure auto-update settings for Base
Previews.

![Select the project](/_images/select-a-project.png)

Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.

![Go to Repository Settings](/_images/go-to-repository-settings.png)

Go to {{% ui-text %}}Refresh Base Previews Automatically{{% /ui-text %}}. Toggle
the checkbox and/or adjust the frequency and timing of these automatic updates.

![Toggle or adjust frequency/time for Refresh Base Previews Automatically setting](/_images/repository-settings-refresh-base-previews-automatically.png)

Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save your
changes.

![Repository Settings -> Press Save Configuration button](/_images/repository-settings-press-save-configuration.png)

{{% /expand%}}
