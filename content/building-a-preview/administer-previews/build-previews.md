---
title: "Build Previews"
date: 2019-09-24T11:47:08-04:00
weight: 1
---

You can build a Preview in a few different ways:

- [Manually build a Preview](#manually-build-a-preview)
- [Auto-generate Previews](#auto-generate-a-preview)

You can also duplicate a Preview using the [Clone Preview](#duplicate-a-preview)
option. This is a great option if you want a few copies of a Preview so QA and
Product can both poke a Preview simultaneously, without worrying about what the
other person is doing.

### Manually build a Preview

To build a Preview:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to build a Preview.
3. Click the name of the repo that contains the code you want to use to build
   the Preview.
4. Scroll down to the {{% ui-text %}}Available to Build{{% /ui-text %}} section;
   by default, you'll see _Pull Requests_, but you can switch to view Branches
   or Tags that are available to Preview.
5. Press the {{% ui-text %}}Build Preview{{% /ui-text %}} button to begin the
   build.

While the Preview is building, you'll see the Preview appear in the
{{% ui-text %}}Latest Previews{{% /ui-text %}} section, with a yellow status
indicator _building_.

When the Preview is ready, the {{% ui-text %}}Preview{{% /ui-text %}} button
will turn blue, and you'll see a green status indicator _ready_. Press the
{{% ui-text %}}Preview{{% /ui-text %}} button to view the Preview. While you're
at it, go ahead and [share your Preview](../../share-a-preview/) - we know
you're proud of your work!

{{% notice note %}} When you go to build a Preview, you may see an arrow
indicating a drop-down menu next to the {{% ui-text %}}Build
Preview{{% /ui-text %}} button. This menu contains additional options to build
your Preview from a Base Preview, or build with no Base Preview. For more info
on these options, see:
[Building Previews when you're using a Base Preview](../../work-with-base-previews/building-new-previews/).
{{% /notice %}}

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to build a Preview.

![Select the project](/_images/select-a-project.png)

Click the name of the repo that contains the code you want to use to build the
Preview.

![Click into the repository](/_images/manually-build-click-into-repo.png)

Scroll down to the {{% ui-text %}}Available to Build{{% /ui-text %}} section; by
default, you'll see _Pull Requests_, but you can switch to view Branches or Tags
that are available to Preview.

![Scroll to Available to Build](/_images/manually-build-scroll-to-available-to-build.png)

Press the {{% ui-text %}}Build Preview{{% /ui-text %}} button to begin the
build.

![Build preview](/_images/manually-build-click-build-preview-button.png)

While the Preview is building, you'll see the Preview appear in the
{{% ui-text %}}Latest Previews{{% /ui-text %}} section, with a yellow status
indicator _building_.

![Preview building](/_images/manually-build-preview-building.png)

When the Preview is ready, the {{% ui-text %}}Preview{{% /ui-text %}} button
will turn blue, and you'll see a green status indicator _ready_. Press the
{{% ui-text %}}Preview{{% /ui-text %}} button to view the Preview. While you're
at it, go ahead and [share your Preview](../../share-a-preview/) - we know
you're proud of your work!

![Preview is ready](/_images/preview-ready.png)

{{% notice note %}} When you look at your new Preview, you'll see the size of
the Preview next to the branch/tag/PR that the Preview was built from. In the
example above, the Preview size is 385.49MB. Because
[billing for Tugboat projects is](/tugboat-billing/tugboat-pricing/#how-does-tugboat-pricing-work),
in part, based on the total size of all the Previews contained within a project,
Preview size becomes an important factor when building out multiple Previews.
Check out our section on
[Optimizing Preview builds](../../preview-deep-dive/optimize-preview-builds/)
for tips on
[reducing Preview size](../../preview-deep-dive/optimize-preview-builds/#optimizing-preview-size).
{{% /notice %}}

### Auto-generate a Preview

In addition to manually building a Preview when you've got an update, you can
configure Tugboat to automatically build a Preview when a pull request is
opened, or when a PR is updated with new code. For more info on this option,
see: [Auto-generate Previews](../../automate-previews/auto-generate/).

### Duplicate a Preview

When Tugboat successfully completes a Preview build, it takes a snapshot of the
container at that moment in time. Tugboat uses this snapshot when you
{{% ui-text %}}Clone{{% /ui-text %}} a Preview, making a near-instantaneous copy
of that Preview with its own container ID and URL. This enables you to share a
Tugboat Preview build with multiple people - for example, Joe in QA and Lisa in
Product - who can then interact with their own version of that Preview without
interfering with what the other folks are doing.

To create a copy of a Preview:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to duplicate a Preview.
3. Click the name of the repo that contains the code you want to use for the
   duplicate Preview.
4. Select the Preview build you want to duplicate.
5. Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that
   Preview, and select {{% ui-text %}}Clone{{% /ui-text %}}.

You'll now see a new Preview with the same name as the Preview you cloned.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to duplicate a Preview.

![Select the project](/_images/select-a-project.png)

Click the name of the repo that contains the code you want to use for the
duplicate Preview.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Select the Preview build you want to duplicate.

![Select a Preview build](/_images/select-a-preview.png)

Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that
Preview, and select {{% ui-text %}}Clone{{% /ui-text %}}.

![Click the Actions drop-down, and select Clone.](/_images/preview-action-clone.png)

You'll now see a new Preview with the same name as the Preview you cloned.

![Cloned Preview](/_images/cloned-preview.png)
