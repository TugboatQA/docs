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

1. Create an account for your Tugboat bot at your preferred git provider; i.e. GitHub, GitLab, BitBucket. and invite
   that user to the repository as an administrator.
2. Optional: [Download the tugboat avatar](https://dashboard.tugboatqa.com/tugboat-avatar.png) to use for your Tugboat
   bot account.
3. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
4. Select the project where you want to switch to the Tugboat bot.
5. Click the {{% ui-text %}}Repository Settings{{% /ui-text %}} link next to the repo where you want to switch to the
   Tugboat bot.
6. Scroll down to the {{% ui-text %}}API Authentication{{% /ui-text %}} section (GitHub API Authentication, GitLab API
   Authentication or BitBucket API Authentication).
7. Press the big blue {{% ui-text %}}Change{{% /ui-text %}} button.
8. Choose {{% ui-text %}}Personal Access Token{{% /ui-text %}} from the drop-down.
9. Carefully read the help text on this next modal window. You will need to go back to your git provider (GitHub,
   GitLab, Bitbucket) and create a personal access token (or App password, as Bitbucket calls it), being sure to grant
   the permissions to the token that are described in the help text on our modal window.
10. Once created, enter the access token for the Tugboat bot user you created at the git provider.
11. Press the {{% ui-text %}}OK{{% /ui-text %}} button.

Now, whenever Tugboat adds comments to a pull request, the comments will display from the Tugboat bot, and the Tugboat
bot's account will get any subsequent notifications from the provider.

{{%expand "Visual Walkthrough" %}}

Create an account for your Tugboat bot at your preferred git provider; i.e. GitHub, GitLab, BitBucket.

![Create an account for your Tugboat bot](../../_images/github-account-for-tugboat-comments.png)

Optional: [Download the Tugboat avatar](https://dashboard.tugboatqa.com/tugboat-avatar.png) to use for your Tugboat bot
account.

![Update Tugboat bot account with the Tugboat avatar](../../_images/github-account-tugboat-avatar.png)

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to switch to the Tugboat bot.

![Select the project](../../_images/select-a-project.png)

Click the {{% ui-text %}}Repository Settings{{% /ui-text %}} link next to the repo where you want to switch to the
Tugboat bot.

![Go to Repository Settings](../../_images/go-to-repository-settings.png)

Scroll down to the {{% ui-text %}}API Authentication{{% /ui-text %}} section (GitHub API Authentication, GitLab API
Authentication or BitBucket API Authentication).

![Scroll to API Authentication](../../_images/scroll-to-api-authentication.png)

Press the big blue {{% ui-text %}}Change{{% /ui-text %}} button.

![Press the Change button](../../_images/api-authentication-press-the-change-button.png)

Choose {{% ui-text %}}Personal Access Token{{% /ui-text %}} from the drop-down.

![Choose Personal Access Token](../../_images/api-authentication-choose-personal-access-token.png)

Carefully read the help text on this next modal window. You will need to go back to your git provider (GitHub, GitLab,
Bitbucket) and create a personal access token (or App password, as Bitbucket calls it), being sure to grant the
permissions to the token that are described in the help text on our modal window.

![Enter authentication details](../../_images/api-authentication-read-instructions.png)

Once created, enter the access token for the Tugboat bot user you created at the git provider.

![Enter authentication details](../../_images/api-authentication-enter-the-access-token.png)

Press the {{% ui-text %}}OK{{% /ui-text %}} button.

![Press OK](../../_images/api-authentication-press-ok-button.png)

{{% /expand%}}
