---
title: "Add a Tugboat Bot to your Team"
date: 2019-09-26T15:16:12-04:00
weight: 5
---

When Tugboat posts comments to a pull request, those comments show as being made by the user who linked Tugboat to the
git repository. In practice, this means that the person who sets up the Tugboat account will get the git provider's
notifications on pull requests; not because they're intentionally watching or commenting on the pull requests, but
because of the automated comments that Tugboat posts as that person.

If you'd instead like those comments to show as coming from Tugboat - and free the user who links the account from a
barrage of notifications - you can add a Tugboat bot to your team.

## To add a Tugboat bot to your team

1. Create an account for your Tugboat bot at your preferred git provider; i.e. GitHub, GitLab, BitBucket.
2. Optional: [Download the tugboat avatar](https://dashboard.tugboat.qa/tugboat-avatar.png) to use for your
   Tugboat bot account.
3. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.
4. Select the project where you want to switch to the Tugboat bot.
5. Click the {{% ui-text %}}Repository Settings{{% /ui-text %}} link next to the repo where you want to switch to the
   Tugboat bot.
6. Scroll down to the {{% ui-text %}}Provider Comments{{% /ui-text %}} section (GitHub Comments, GitLab Comments or
   BitBucket Comments).
7. Press the big blue {{% ui-text %}}Change{{% /ui-text %}} button.
8. Enter the authentication details for the Tugboat bot user you created at the git provider.
9. Press the {{% ui-text %}}OK{{% /ui-text %}} button.

Now, whenever Tugboat adds comments to a pull request, the comments will display from the Tugboat bot, and the Tugboat
bot's account will get any subsequent notifications from the provider.

{{%expand "Visual Walkthrough" %}}

Create an account for your Tugboat bot at your preferred git provider; i.e. GitHub, GitLab, BitBucket.

![Create an account for your Tugboat bot](../../_images/github-account-for-tugboat-comments.png)

Optional: [Download the Tugboat avatar](https://dashboard.tugboat.qa/tugboat-avatar.png) to use for your
Tugboat bot account.

![Update Tugboat bot account with the Tugboat avatar](../../_images/github-account-tugboat-avatar.png)

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to switch to the Tugboat bot.

![Select the project](../../_images/select-a-project.png)

Click the {{% ui-text %}}Repository Settings{{% /ui-text %}} link next to the repo where you want to switch to the
Tugboat bot.

![Go to Repository Settings](../../_images/go-to-repository-settings.png)

Scroll down to the {{% ui-text %}}Provider Comments{{% /ui-text %}} section (GitHub Comments, GitLab Comments or
BitBucket Comments).

![Scroll to Provider Comments](../../_images/scroll-to-provider-comments.png)

Press the big blue {{% ui-text %}}Change{{% /ui-text %}} button.

![Press the Change button](../../_images/provider-comments-press-the-change-button.png)

Enter the authentication details for the Tugboat bot user you created at the git provider.

![Enter authentication details](../../_images/provider-comments-enter-authentication-details.png)

Press the {{% ui-text %}}OK{{% /ui-text %}} button.

![Press OK](../../_images/provider-comments-press-ok-button.png)

{{% /expand%}}
