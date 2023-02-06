---
title: "Building New Previews"
date: 2019-09-24T11:55:35-04:00
weight: 9
---

When you're building Previews after you've set a Base Preview, those Preview builds are child builds of the Base
Preview. They use the Base Preview's [build snapshot](../../preview-deep-dive/how-previews-work/#the-build-snapshot) for
things like setting up Services, including pulling Docker images, and pulling in any assets that are imported during the
`init` or `update` phase of the Base Preview build.

When you're working with Previews that are child Previews of a Base Preview, Build and Rebuild start from the `build`
phase, bypassing the `init` and `refresh` phases of a build. This includes:

- [Manual Preview Builds](../../administer-previews/build-previews/#manually-build-a-preview) (when you do not specify
  building from scratch)
- [Previews that are automatically built from pull requests](../../automate-previews/auto-generate).
- [Rebuilding child Previews](../../administer-previews/change-or-update-previews/#rebuild-previews)
- [Rebuild orphaned Previews automatically](../../../setting-up-tugboat/select-repo-settings/#rebuild-orphaned-previews-automatically)

For more info on build phases, see:
[the build process: explained](../../preview-deep-dive/how-previews-work/#the-build-process-explained).

After you've set a Base Preview, you do have one option to build new Previews that do not use the Base Preview: manually
build a Preview from scratch. A Preview built this way is not a child Preview, and behaves like a typical Preview when
Building or Rebuilding.

## Build a Preview with no Base Preview

To manually build a Preview with no Base Preview:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to build a Preview.
3. Click into the repo where you want to build a Preview.
4. Go to the {{% ui-text %}}Available to Build{{% /ui-text %}} section of the Repository Dashboard.
5. Click into the drop-down next to the {{% ui-text %}}Build Preview{{% /ui-text %}} button for the Preview you'd like
   to build from scratch.
6. Select the {{% ui-text %}}Build with no base preview{{% /ui-text %}} option.

{{% notice info %}} If you build with no base preview from a pull request or tag, you will _not_ see the following
options in the base preview settings for your pull request preview. These options are only available for branch-based
previews:

        [ ] Repository Base Preview
            Use this Preview as a Base Preview for all new Previews built for this Repository.
        [ ] Branch Base Preview
            Only use this Preview as a Base Preview for new pull request Previews that merge into the main branch.

{{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to build a Preview.

![Select the project](/_images/select-a-project.png)

Click into the repo where you want to build a Preview.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Go to the {{% ui-text %}}Available to Build{{% /ui-text %}} section of the Repository Dashboard.

![Scroll to Available to Build](/_images/scroll-to-available-to-build.png)

Click into the drop-down next to the {{% ui-text %}}Build Preview{{% /ui-text %}} button for the Preview you'd like to
build from scratch.

![Go to the Build Preview drop-down menu](/_images/go-to-build-preview-drop-down.png)

Select the {{% ui-text %}}Build with no base preview{{% /ui-text %}} option.

![Select Build with no base preview](/_images/select-build-with-no-base-preview.png)

{{% /expand%}}

## Build a Preview from a specific Base Preview

If you want to use a Preview as a Base Preview for a specific Preview build, but don't want to set it as a
[Repository](/building-a-preview/preview-deep-dive/how-previews-work/#repository-base-preview) or
[Branch Base Preview](/building-a-preview/preview-deep-dive/how-previews-work/#branch-base-preview), you can manually
build a Preview from a specific Base Preview.

To build a Preview from a specific Base Preview:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to build a Preview from a specific Base Preview.
3. Click into the repo where you want to build a Preview from a specific Base Preview.
4. Go to the {{% ui-text %}}Available to Build{{% /ui-text %}} section of the Repository Dashboard.
5. Click into the drop-down next to the {{% ui-text %}}Build Preview{{% /ui-text %}} button for the Preview you'd like
   to build from a specific Base Preview.
6. Select the {{% ui-text %}}Select a base preview{{% /ui-text %}} option.
7. Click the checkbox(es) next to any Base Previews you want to use as the basis for your new Preview build(s).
8. Press the {{% ui-text %}}OK{{% /ui-text %}} button.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to build a Preview from a specific Base Preview.

![Select the project](/_images/select-project-to-set-base-preview.png)

Click into the repo where you want to build a Preview from a specific Base Preview.

![Select the Tugboat repository](/_images/select-repo-to-set-base-preview.png)

Go to the {{% ui-text %}}Available to Build{{% /ui-text %}} section of the Repository Dashboard.

![Go to the Available to Build section of the Repository Dashboard](/_images/go-to-available-to-build.png)

Click into the drop-down next to the {{% ui-text %}}Build Preview{{% /ui-text %}} button for the Preview you'd like to
build from a specific Base Preview.

![Click into the drop-down next to the Build Preview button](/_images/click-into-drop-down-next-to-build-preview.png)

Select the {{% ui-text %}}Select a base preview{{% /ui-text %}} option.

![Click the Select a base preview option](/_images/click-select-a-base-preview.png)

Click the checkbox(es) next to any Previews you want to use as the basis for your new Preview build(s).

![Click checkboxes to select the Previews you want to use as the basis for a Preview build](/_images/select-previews-to-use-as-base-preview.png)

Press the {{% ui-text %}}OK{{% /ui-text %}} button.

![Press the OK button](/_images/specify-base-previews-for-preview-build-press-ok.png)

{{% /expand%}}
