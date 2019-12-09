---
title: "Change or Update Previews"
date: 2019-09-24T11:48:14-04:00
weight: 3
---

Want to update or change a Preview build? Tugboat offers a few different ways to
do that:

- To update a Preview with your latest code, you can
  [Refresh](#refresh-previews) it. Refreshing a Preview pulls in the latest code
  from the connected Git repo, and run commands from the from the Tugboat config
  file's `update` and `build` phases.
- To change a Preview's Docker images, or the make changes to Services' `init`
  commands, you can [Rebuild](#rebuild-previews) it. Rebuilding a Preview pulls
  fresh Docker images, pulls in the latest code from the connected Git repo, and
  runs all of the Tugboat config file's `init`, `update` and `build` commands.

On a basic level, you can think of it as the difference between updating the
code (Refresh) and making more substantial changes to the way a Service is
configured (Rebuild). For more info on what exactly is happening under the
covers, take a look at
[the Preview build process: explained](../../preview-deep-dive/how-previews-work/#the-build-process-explained).

{{% notice note %}} When you're updating a Preview that was built from a Base
Preview, Rebuild does not pull fresh Docker images and run commands from `init`
and `update`. Instead, child Previews jump directly to the `build` phase. For
more info, see:
[rebuild Previews when working with a Base Preview](../../work-with-base-previews/building-new-previews).
{{% /notice %}}

## Refresh Previews

When you Refresh a Preview, Tugboat:

1. Pulls the latest code from git.
2. Runs commands from the `update` section of the config file.
3. Runs commands from the `build` section of the config file.

When you're not [using a Base Preview](../../work-with-base-previews/),
Refreshing is a faster process than building the entire container again, as
Tugboat doesn't have to set up Services and complete all the `init` processes
again. However, if you are using a Base Preview, [Rebuild](#rebuild-previews) is
the faster update process.

For more info about build phases, see:
[the build process: explained](../../preview-deep-dive/how-previews-work/#the-build-process-explained).

### To Refresh a Preview:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to update a Preview.
3. Click the name of the repo that contains the code you want to use for the
   Preview update.
4. Select the Preview build you want to update.
5. Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that
   Preview, and select {{% ui-text %}}Refresh{{% /ui-text %}}.
6. Press the {{% ui-text %}}Yes{{% /ui-text %}} button to confirm and start the
   Refresh process.

You'll see a yellow _refreshing_ status while Tugboat is running the update,
which will change to a green _ready_ once the update is complete.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to update a Preview.

![Select the project](/_images/select-a-project.png)

Click the name of the repo that contains the code you want to use for the
Preview update.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Select the Preview build you want to update.

![Select a Preview build](/_images/select-a-preview.png)

Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that
Preview, and select {{% ui-text %}}Refresh{{% /ui-text %}}.

![Click the Actions drop-down, and select Refresh.](/_images/preview-action-refresh.png)

Press the {{% ui-text %}}Yes{{% /ui-text %}} button to confirm and start the
Refresh process.

![Press Yes to confirm and begin Refresh](/_images/preview-action-confirm-refresh.png)

You'll see a yellow _refreshing_ status while Tugboat is running the update,
which will change to a green _ready_ once the update is complete.

{{% /expand%}}

## Rebuild Previews

When you Rebuild a Preview (that was not built using a Base Preview), Tugboat:

1. Pulls the latest code from git.
2. Pulls fresh Docker images.
3. Runs commands from the `init` section of the configuration.
4. Runs commands from the `update` section of the configuration.
5. Runs commands from the `build` section of the configuration.

When you're not [using a Base Preview](../../work-with-base-previews/), this
process takes longer than a [Refresh](#refresh-previews), so you should mainly
use this if you need to pull new Docker images, or run commands from `init` in
your config.yml. However, if you are using a Base Preview, Rebuild is the faster
update process.

For more info about build phases, see:
[the build process: explained](../../preview-deep-dive/how-previews-work/#the-build-process-explained).

### To Rebuild a Preview:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to rebuild a Preview.
3. Click the name of the repo that contains the code you want to use for the
   Preview rebuild.
4. Select the Preview you want to rebuild.
5. Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that
   Preview, and select {{% ui-text %}}Rebuild{{% /ui-text %}}.
6. Press the {{% ui-text %}}Yes{{% /ui-text %}} button to confirm and start the
   Rebuild process.

You'll see a yellow _building_ status while Tugboat is rebuilding the Preview,
which will change to a green _ready_ once the build is complete.

{{% notice note %}} When you Rebuild a Preview that was built from a Base
Preview, Rebuild does not pull fresh Docker images and run commands from `init`
and `update`. Instead, child Previews jump directly to the `build` phase. For
more info, see:
[updating Previews when working with a Base Preview](../../work-with-base-previews/building-new-previews/).
{{% /notice %}}

{{%expand "Visual Walkthrough" %}}

To Rebuild a Preview:

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to rebuild a Preview.

![Select the project](/_images/select-a-project.png)

Click the name of the repo that contains the code you want to use for the
Preview rebuild.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Select the Preview you want to rebuild.

![Select a Preview build](/_images/select-a-preview.png)

Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that
Preview, and select {{% ui-text %}}Rebuild{{% /ui-text %}}.

![Click the Actions drop-down, and select Rebuild.](/_images/preview-action-rebuild.png)

Press the {{% ui-text %}}Yes{{% /ui-text %}} button to confirm and start the
Rebuild process.

![Press Yes to confirm and begin Rebuild](/_images/preview-action-confirm-rebuild.png)

You'll see a yellow _building_ status while Tugboat is rebuilding the Preview,
which will change to a green _ready_ once the build is complete.

{{% /expand%}}
