---
title: "Change Preview States"
date: 2019-09-24T11:48:32-04:00
weight: 7
---

When working with Previews, there are a few handy things you can do in the {{% ui-text %}}Actions{{% /ui-text %}} menu
beyond updating and deleting your Previews. You can change the states of your Previews in a few different ways:

- [Start, Stop](#start-stop)
- [Lock, Unlock](#lock-unlock)
- [Reset](#reset)

## Start, Stop

Sometimes, you might want to stop all of a Preview's Services and take it offline. You can use the
{{% ui-text %}}Stop{{% /ui-text %}} option in the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu to take the
Preview offline. This is different from a suspended Preview, in that a suspended Preview will start again automatically
if someone visits the Preview link, while a Stopped Preview remains stopped until someone manually Starts it.

On the flip side, Starting a Preview resumes all Services. You can Start a Preview that is suspended or Stopped.

### To Start or Stop a Preview:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to Stop or Start a Preview.
3. Click into the repo where you want to Stop/Start a Preview.
4. Select the Preview you want to Stop or Start.
5. Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that Preview, and select
   {{% ui-text %}}Stop{{% /ui-text %}} or {{% ui-text %}}Start{{% /ui-text %}}.

When the Preview is successfully stopped, you'll see a red _stopped_ status. When a Preview is Starting, you'll see a
yellow _starting_ or _resuming_ (depending on whether the Preview was Stopped or Suspended), and then the Preview will
go to a green _ready_ status.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to Stop or Start a Preview.

![Select the project](/_images/select-a-project.png)

Click into the repo where you want to Stop/Start a Preview.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Select the Preview you want to Stop or Start.

![Select a Preview build](/_images/select-a-preview.png)

Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that Preview, and select
{{% ui-text %}}Stop{{% /ui-text %}} or {{% ui-text %}}Start{{% /ui-text %}}.

![Click the Actions drop-down, and select Stop or Start.](/_images/preview-action-stop.png)

When the Preview is successfully stopped, you'll see a red _stopped_ status. When a Preview is Starting, you'll see a
yellow _starting_ or _resuming_ (depending on whether the Preview was Stopped or Suspended), and then the Preview will
go to a green _ready_ status.

{{% /expand%}}

## Lock, Unlock

If you want a Preview to remain in its current state without being updated, you can Lock the Preview. Locking a Preview
prevents Tugboat from making updates, including things like automated updates from new pull request commits, until the
Preview is Unlocked again. You might want to Lock a Preview to preserve its state for a longer review, or to avoid
interruptions during a demo.

When you're ready to make updates to the Preview again, whether manually or automated updates, Unlock the Preview.

### To Lock or Unlock a Preview:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to Lock or Unlock a Preview.
3. Click into the repo where you want to Lock/Unlock a Preview.
4. Select the Preview you want to Lock or Unlock.
5. Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that Preview, and select
   {{% ui-text %}}Lock{{% /ui-text %}} or {{% ui-text %}}Unlock{{% /ui-text %}}.

When the Preview is successfully locked, you'll see a closed padlock icon next to its status - in this example, it's a
green icon next to the _ready_ status. When the Preview is unlocked, the padlock icon turns into the regular state
indicator.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to Lock or Unlock a Preview.

![Select the project](/_images/select-a-project.png)

Click into the repo where you want to Lock/Unlock a Preview.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Select the Preview you want to Lock or Unlock.

![Select a Preview build](/_images/select-a-preview.png)

Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that Preview, and select
{{% ui-text %}}Lock{{% /ui-text %}} or {{% ui-text %}}Unlock{{% /ui-text %}}.

![Click the Actions drop-down, and select Lock or Unlock.](/_images/preview-action-lock.png)

When the Preview is successfully locked, you'll see a closed padlock icon next to its status - in this example, it's a
green icon next to the _ready_ status. When the Preview is unlocked, the padlock icon turns into the regular state
indicator.

{{% /expand%}}

## Reset

When a Preview build completes, Tugboat takes a
[snapshot of the completed build](../../preview-deep-dive/how-previews-work/#the-build-snapshot). If you want to go back
to that state - for example, if you want to undo any changes that were made during testing or a demo - you can Reset a
Preview to go back to that post-build snapshot.

### To Reset a Preview:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to Reset a Preview.
3. Click into the repo where you want to Reset a Preview.
4. Select the Preview you want to Reset.
5. Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that Preview, and select
   {{% ui-text %}}Reset{{% /ui-text %}}.
6. Press the {{% ui-text %}}Yes{{% /ui-text %}} button to confirm.

You'll see a yellow _resetting_ status for a moment while the Preview is returned to its snapshot state, and then the
Preview will become _ready_ again.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project where you want to Reset a Preview.

![Select the project](/_images/select-a-project.png)

Click into the repo where you want to Reset a Preview.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Select the Preview you want to Reset.

![Select a Preview build](/_images/select-a-preview.png)

Click the {{% ui-text %}}Actions{{% /ui-text %}} drop-down menu for that Preview, and select
{{% ui-text %}}Reset{{% /ui-text %}}.

![Click the Actions drop-down, and select Reset.](/_images/preview-action-reset.png)

Press the {{% ui-text %}}Yes{{% /ui-text %}} button to confirm.

![Press Yes to confirm Reset](/_images/preview-action-confirm-reset.png)

You'll see a yellow _resetting_ status for a moment while the Preview is returned to its snapshot state, and then the
Preview will become _ready_ again.

{{% /expand%}}
