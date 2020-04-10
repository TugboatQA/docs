---
title: "Stop Using a Base Preview"
date: 2019-09-24T11:52:51-04:00
weight: 5
---

When you no longer want new Preview Builds to use a Base Preview; for example, if you've moved to a new concept, want to
switch to a development branch or otherwise want to stop using a Base Preview; you can remove that Base Preview. This
keeps the Base Preview and child Previews in your Tugboat project, but new builds will no longer start with this Base
Preview. If you want to delete a Base Preview, instead, see: [Delete a Base Preview](../delete-base-preview/).

## To stop using a Base Preview:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to stop using a Base Preview.
3. Click into the repo where you want to stop using a Base Preview.
4. Find the Preview you'd like to stop using as a Base Preview, and go into {{% ui-text %}}Settings{{% /ui-text %}} for
   that Preview.
5. Click the checkbox next to {{% ui-text %}}Use this Preview as a Base Preview{{% /ui-text %}} to deselect the Preview
   as a Base Preview.
6. Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button.

The deselected Preview will disappear from the Base Preview section of the dashboard, and subsequent Preview builds -
including automated builds from git provider integrations - will no longer start from that Base Preview.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to stop using a Base Preview.

![Select the project](/_images/select-project-to-set-base-preview.png)

Click into the repo where you want to stop using a Base Preview.

![Click into Tugboat repository](/_images/select-repo-to-set-base-preview.png)

Find the Preview you'd like to stop using as a Base Preview, and go into {{% ui-text %}}Settings{{% /ui-text %}} for
that Preview.

![Go into Settings for the Preview you want to stop using as a Base Preview](/_images/go-into-settings-for-base-preview-you-want-to-stop-using.png)

Click the checkbox next to {{% ui-text %}}Use this Preview as a Base Preview{{% /ui-text %}} to deselect the Preview as
a Base Preview.

![Click checkbox to deselect a Base Preview](/_images/click-checkbox-to-deselect-base-preview.png)

Press the {{% ui-text %}}Save Configuration{{% /ui-text %}} button.

![Press the Save Configuration button](/_images/stop-using-base-preview-press-save-configuration.png)

{{% /expand%}}
