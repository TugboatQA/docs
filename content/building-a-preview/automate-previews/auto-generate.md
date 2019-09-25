---
title: "Auto-generate Previews"
date: 2019-09-24T11:49:35-04:00
weight: 1
---

We love automatically generating Previews from new pull requests - we think it's
one of Tugboat's best features! {{% ui-text %}}Build Pull Requests
Automatically{{% /ui-text %}} kicks off a new Preview build whenever a pull
request is opened in your linked git repository.

If you're [using a Base Preview](/building-a-preview/work-with-base-previews/),
the automated Preview build starts from that Base Preview.

{{% notice warning %}} When you enable this functionality, Tugboat does not
automatically build pull requests from forked repositories. That requires you to
set an additional option: {{% ui-text %}}Build Previews for Forked Pull
Requests{{% /ui-text %}}. Any secrets in your Preview will be accessible by the
owner of the forked repository, so this setting is turned off by default.
Automated Preview Build requests from forked repositories appear as failed
Preview builds in your Tugboat Dashboard. For more info, see:
[Troubleshooting -> Tugboat Error Messages 1074](/troubleshooting/fix-problem-x/#1074-repo-configuration-does-not-allow-building-of-pull-requests-from-forks).
{{% /notice %}}

### To set Tugboat to automatically Build Previews

To configure Tugboat to auto-generate Previews, you'll need to:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to configure auto-generate settings for
   Previews.
3. Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.
4. Click the checkboxes for the auto-generate features you'd like to turn
   on/off.
5. Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save
   your changes.

{{% notice tip %}} Don't see the options to auto-generate Previews from pull
requests? You'll need to
[connect your preferred git provider to Tugboat](/setting-up-tugboat/connect-with-your-provider/),
and then
[delete](/setting-up-tugboat/select-repo-settings/#delete-the-repository) and
[re-add the provider-specific version of the repository](/setting-up-tugboat/add-repos-to-the-project/)
to your Tugboat project. {{% /notice %}}

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to configure auto-generate settings for
Previews.

![Select the project](/_images/select-a-project.png)

Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.

![Go to Repository Settings](/_images/go-to-repository-settings.png)

Click the checkboxes for the auto-generate features you'd like to turn on/off.

![Click the checkboxes to turn auto-build Preview options on or off](/_images/auto-build-preview-repository-settings.png)

Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save your
changes.

![Press the Save Configuration button](/_images/repository-settings-press-save-configuration.png)
