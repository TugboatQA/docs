---
title: "Set a Base Preview"
date: 2019-09-24T11:51:23-04:00
weight: 1
---

Whether you want to set one Base Preview, or [set multiple Base Previews](#add-multiple-base-previews), the process is
the same:

## How to set a Base Preview

To create a Base Preview, you'll first need to have a [Preview build](../../administer-previews/build-previews/) to
serve as your starting point.

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to set a Base Preview.
3. Click the name of the repo that contains Preview you want to use as a Base Preview.
4. Find the Preview you'd like to set as a Base Preview, and go into {{% ui-text %}}Settings{{% /ui-text %}} for that
   Preview.
5. Click the checkbox next to {{% ui-text %}}Use this Preview as a Base Preview{{% /ui-text %}}.
6. Select the Base Preview Type. For more about Base Preview types, see:
   [Base Preview Auto Select](../../preview-deep-dive/how-previews-work/#base-preview-auto-select).
7. Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button.

That preview will be moved to the {{% ui-text %}}Base Preview{{% /ui-text %}} section of the Repository Dashboard. From
now on, Previews that match the [Base Preview type](../../preview-deep-dive/how-previews-work/#base-preview-auto-select)
will build from the snapshot created when that Base Preview was built.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to set a Base Preview.

![Select the project](/_images/select-project-to-set-base-preview.png)

Click the name of the repo that contains Preview you want to use as a Base Preview.

![Select the Tugboat repository](/_images/select-repo-to-set-base-preview.png)

Find the Preview you'd like to set as a Base Preview, and go into {{% ui-text %}}Settings{{% /ui-text %}} for that
Preview.

![Go into Settings for the Preview you want to use as a Base Preview](/_images/set-base-preview-go-into-preview-settings.png)

Click the checkbox next to {{% ui-text %}}Use this Preview as a Base Preview{{% /ui-text %}}.

![Click the checkbox to set this Preview as a Base Preview](/_images/click-checkbox-to-use-preview-as-base-preview.png)

Select the Base Preview Type. For more about Base Preview types, see:
[Base Preview Auto Select](../../preview-deep-dive/how-previews-work/#base-preview-auto-select).

![Click the radio button next to the appropriate Base Preview Type](/_images/select-repository-base-preview.png)

Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button.

![Press the Save Configuration button to save changes](/_images/preview-settings-press-save-configuration-button.png)

That preview will be moved to the {{% ui-text %}}Base Preview{{% /ui-text %}} section of the Repository Dashboard.

![View of Base Preview in repository](/_images/new-base-preview-in-base-previews.png)

If you're ever wondering which Base Preview was used when generating a Preview, check under the name of the Preview;
you're looking for the "from _Base Preview Name_":

![View Base Preview for Preview](/_images/view-base-preview-for-preview.png)

{{% /expand%}}

## Add multiple Base Previews

You can add multiple Base Previews to a project, following the directions outlined above.

![Set multiple Base Previews](/_images/view-multiple-base-previews.png)

When you've set multiple Base Previews, every new Preview build (including automated builds from pull requests) will
create a build from _all_ Base Preview Types that match the new Preview build. For more information on Base Preview
matching, see: [Base Preview Auto Select](../../preview-deep-dive/how-previews-work/#base-preview-auto-select).

In my sample project, I've set two Repository Base Previews, and building a Preview from a new PR automatically created
two Previews - one for each Base Preview.

![Multiple Base Previews generating multiple Preview builds](/_images/multiple-base-preview-builds.png)
