---
title: "Auto-delete Previews"
date: 2019-09-24T11:49:57-04:00
weight: 5
---

Each of the Previews in your Tugboat project count toward the total storage space available in your
[project's billing tier](/tugboat-billing/tugboat-pricing/). By default, Tugboat is configured to automatically delete
Previews when their corresponding git pull requests are merged or closed.

## To automatically delete Previews:

If you want to change the setting to automatically delete Previews when their PRs are merged or closed:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to configure auto-delete settings for Previews.
3. Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.
4. Click the checkbox to change the setting.
5. Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save your changes.

## Delete Previews after a number of days

You can also have Tugboat delete new Previews after a set number of days, even when their pull requests stay open. This
is useful for keeping storage use down.

To set the number of days:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project that contains the repository.
3. Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.
4. In the {{% ui-text %}}Preview expiration{{% /ui-text %}} field, enter the number of days after which Tugboat deletes
   a new Preview.
5. Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save your changes.

Keep these details in mind:

- The default is `0`, which turns off Preview expiration. Existing repositories do not delete Previews until you change
  this value.
- The value must be a whole number. The maximum is 1825 days (5 years).
- Only repository admins can change this setting. Other users see the field, but cannot edit it.
- The setting applies to Previews created after you save it. Tugboat sets each new Preview to expire the chosen number
  of days after it is created.
- Tugboat does not set an expiration on
  [Base Previews](/building-a-preview/work-with-base-previews/set-a-base-preview/). When you set a Preview as a Base
  Preview, Tugboat clears its expiration.
- A Preview that already has an `expires` value, for example one created with the `expires` option in the
  [CLI](/tugboat-cli/use-the-cli/), keeps that value instead of the repository setting.
- Tugboat does not delete a locked Preview until you unlock it.

When a Preview has an expiration date, its page shows the date on which Tugboat deletes it. For a locked Preview, the
page shows the date followed by "if unlocked".

You can also set the value with the CLI. For example, to delete new Previews after 14 days:

```sh
tugboat update <repo-id> expire_days=14
```

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to configure auto-delete settings for Previews.

![Select the project](/_images/select-a-project.png)

Click into {{% ui-text %}}Settings{{% /ui-text %}} for the repository.

![Go to Repository Settings](/_images/go-to-repository-settings.png)

Click the checkbox to change the setting.

![Click the checkbox to turn auto-delete Preview on or off](/_images/auto-delete-preview-repository-settings.png)

Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button to save your changes.

![Press the Save Configuration button](/_images/repository-settings-press-save-configuration.png)

{{% /expand%}}
