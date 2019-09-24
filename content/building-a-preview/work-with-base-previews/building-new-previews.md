---
title: "Building New Previews"
date: 2019-09-24T11:55:35-04:00
weight: 9
---

When you're building Previews after you've set a Base Preview, those Preview
builds are child builds of the Base Preview. They use the Base Preview's
[build snapshot](../../preview-deep-dive/how-previews-work/#the-build-snapshot)
for things like setting up Services, including pulling Docker images, and
pulling in any assets that are imported during the `init` or `update` phase of
the Base Preview build.

When you're working with Previews that are child Previews of a Base Preview,
Build and Rebuild start from the `build` phase, bypassing the `init` and
`refresh` phases of a build. This includes:

- [Manual Preview Builds](../../administer-previews/build-previews/#manually-build-a-preview)
  (when you do not specify building from scratch)
- [Previews that are automatically built from pull requests](../../automate-previews/auto-generate).
- [Rebuilding child Previews](../../administer-previews/change-or-update-previews/#rebuild-previews)
- [Rebuild orphaned Previews automatically](../../../setting-up-tugboat/select-repo-settings/#rebuild-orphaned-previews-automatically)

For more info on build phases, see:
[the build process: explained](../../preview-deep-dive/how-previews-work/#the-build-process-explained).

After you've set a Base Preview, you do have one option to build new Previews
that do not use the Base Preview: manually build a Preview from scratch. A
Preview built this way is not a child Preview, and behaves like a typical
Preview when Building or Rebuilding.

## Build a Preview with no Base Preview

To manually build a Preview with no Base Preview:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to build a Preview.
3. Click into the repo where you want to build a Preview.
4. Go to the **Available to Build** section of the Repository Dashboard.
5. Click into the drop-down next to the **Build Preview** button for the Preview
   you'd like to build from scratch.
6. Select the **Build with no base preview** option.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to build a Preview.

![Select the project](/_images/select-a-project.png)

Click into the repo where you want to build a Preview.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Go to the **Available to Build** section of the Repository Dashboard.

![Scroll to Available to Build](/_images/scroll-to-available-to-build.png)

Click into the drop-down next to the **Build Preview** button for the Preview
you'd like to build from scratch.

![Go to the Build Preview drop-down menu](/_images/go-to-build-preview-drop-down.png)

Select the **Build with no base preview** option.

![Select Build with no base preview](/_images/select-build-with-no-base-preview.png)
