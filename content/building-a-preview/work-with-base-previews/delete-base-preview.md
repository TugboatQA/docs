---
title: "Delete a Base Preview"
date: 2019-09-24T11:53:17-04:00
weight: 7
---

Want to delete a Base Preview you're not using anymore? Keep in mind that if you delete a Base Preview that was used to
generate child Previews, those child Previews will grow to their full size, which could put your project over the
[limit of disk space](/tugboat-billing/tugboat-pricing/#how-does-tugboat-pricing-work) available to the project. If you
don't want this, you can [stop using a Base Preview](../stop-using-base-preview/) to stop building new child Previews
from this Preview, but preserve the current size of existing child Previews.

{{% notice note %}} When you exceed the disk space limit in your project, you won't be able to build new Previews until
you are under the project's disk space limit again. You can get under the project's space limit by
[deleting Previews](../../administer-previews/delete-previews/), or
[increasing your project's billing tier](/tugboat-billing/tugboat-pricing/#change-your-tugboat-plan). {{% /notice %}}

## To delete a Base Preview:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to delete a Base Preview.
3. Click into the repo where you want to delete a Base Preview.
4. Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for the Base Preview you want to delete, and select
   {{% ui-text %}}Delete{{% /ui-text %}}.
5. Click the checkbox next to {{% ui-text %}}Yes, delete this preview{{% /ui-text %}} and then press the
   {{% ui-text %}}Delete{{% /ui-text %}} button to confirm.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to delete a Base Preview.

![Select the project](/_images/select-a-project.png)

Click into the repo where you want to delete a Base Preview.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for the Base Preview you want to delete, and select
{{% ui-text %}}Delete{{% /ui-text %}}.

![Click the Actions drop-down, and select Delete.](/_images/base-preview-actions-delete.png)

Click the checkbox next to {{% ui-text %}}Yes, delete this preview{{% /ui-text %}} and then press the
{{% ui-text %}}Delete{{% /ui-text %}} button to confirm.

![Confirm Preview delete and press Delete button](/_images/base-preview-press-delete-button.png)

{{% /expand%}}
