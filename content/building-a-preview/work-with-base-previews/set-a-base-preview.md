---
title: "Set a Base Preview"
date: 2019-09-24T11:51:23-04:00
weight: 1
---

Whether you want to set one Base Preview, or
[set multiple Base Previews](#add-multiple-base-previews), the process is the
same:

## How to set a Base Preview

To create a Base Preview, you'll first need to have a
[Preview build](../../administer-previews/build-previews/) to serve as your
starting point.

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to set a Base Preview.
3. Click the name of the repo that contains Preview you want to use as a Base
   Preview.
4. Go to the {{% ui-text %}}Manage Base Previews{{% /ui-text %}} link on the
   Repository Dashboard.
5. Click the checkbox next to the Preview you want to use as a Base Preview.
6. Press the {{% ui-text %}}OK{{% /ui-text %}} button.

That preview will be moved to the {{% ui-text %}}Base Preview{{% /ui-text %}}
section of the Repository Dashboard. From now on, Previews will build from the
snapshot created when the Base Preview was built.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to set a Base Preview.

![Select the project](/_images/select-a-project.png)

Click the name of the repo that contains Preview you want to use as a Base
Preview.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Go to the {{% ui-text %}}Manage Base Previews{{% /ui-text %}} link on the
Repository Dashboard.

![Go to Manage Base Previews](/_images/set-base-preview-go-to-manage-base-previews.png)

Click the checkbox next to the Preview you want to use as a Base Preview.

![Click the checkbox to select a Base Preview](/_images/set-base-preview-click-checkbox.png)

Press the {{% ui-text %}}OK{{% /ui-text %}} button.

![Press OK to confirm Base Preview](/_images/set-base-preview-press-ok.png)

That preview will be moved to the {{% ui-text %}}Base Preview{{% /ui-text %}}
section of the Repository Dashboard.

![Base Preview in repository](/_images/set-base-preview-after.png)

If you're ever wondering which Base Preview was used when generating a Preview,
check under the name of the Preview; you're looking for the "from _Base Preview
Name_":

![View Base Preview for Preview](/_images/view-base-preview-for-preview.png)

## Add multiple Base Previews

To set more than one Base Preview, follow the directions above, but check the
checkboxes next to all of the Previews that you'd like to set as Base Previews
when you get to Step 5.

![Set multiple Base Previews](/_images/set-multiple-base-previews.png)

When you've selected multiple Base Previews, every new Preview build (including
automated builds from pull requests) will create a build from _each_ Base
Preview. In my sample project, I've set two base Previews, and building a
Preview from a new PR automatically created two Previews - one for each Base
Preview.

![Multiple Base Previews generating multiple Preview builds](/_images/multiple-base-preview-builds.png)
