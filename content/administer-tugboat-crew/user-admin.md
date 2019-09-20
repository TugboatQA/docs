---
title: "User Admin"
date: 2019-09-19T10:36:14-04:00
weight: 5
---

Every ship captain needs a crew - even a tugboat! Want to add, remove or make
changes to your Tugboat team?

- [Add a user to a project](#add-a-user-to-a-project)
- [Remove a user from a project](#remove-a-user-from-a-project)
- [Change user permissions](#change-user-permissions)
- [Add a Tugboat bot to your team](#add-a-tugboat-bot-to-your-team)
- [User permission levels explained](#user-permission-levels-explained)

{{% notice info %}} User permissions in Tugboat are handled on a per-project
basis. When users have access to a project, they have access to all the
repositories within that project. When inviting users to your project, consider
whether any of your repos contain sensitive data; you may want to split those
repos out into a different project, where only a subset of users get access.
{{% /notice %}}

## Add a user to a project

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to add the user.
3. Click the **Project Settings** link to the right of the project's title.
4. In the **Invite a User to This Project** section, add the recipient's email
   address, and select the appropriate
   [user type](#user-permission-levels-explained) from the drop-down.
5. Press the big blue **Invite** button!

The user you've invited will get an email from `support@tugboat.qa` with a link
to accept the invitation.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to add the user.

![Select the project](../../_images/select-a-project.png)

Click the **Project Settings** link to the right of the project's title.

![Click Project Settings](../../_images/click-project-settings-link.png)

In the **Invite a User to This Project** section, add the recipient's email
address, and select the appropriate
[user type](#user-permission-levels-explained) from the drop-down.

![Add user's email address and select permissions](../../_images/add-user-email-and-permissions.png)

Press the big blue **Invite** button!

![Press the Invite button](../../_images/add-user-press-invite-button.png)

### User doesn't see Tugboat invite

If the user doesn't see the Tugboat invite:

- Have them check Inboxes and Spam for this email address, or;
- **Copy Link** and share it another way from the Pending Invites section of the
  Project Settings, or;
- Hit the **Re-send** link from the Pending Invites section of the Project
  Settings.

![Copy Link or Re-Send from Pending Invites](../../_images/add-user-copy-link-resend.png)

## Remove a user from a project

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to remove the user.
3. Click the **Project Settings** link to the right of the project's title.
4. In the **Manage Users** section, look for the user you want to remove, and
   click the Remove link.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to remove the user.

![Select the project](../../_images/select-a-project.png)

Click the **Project Settings** link to the right of the project's title.

![Click Project Settings](../../_images/click-project-settings-link.png)

In the **Manage Users** section, look for the user you want to remove, and click
the Remove link.

![Go to Manage Users and click Remove](../../_images/remove-user-click-remove-link.png)

## Change user permissions

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to change user permissions.
3. Click the **Project Settings** link to the right of the project's title.
4. In the **Manage Users** section, look for the user whose permissions you want
   to change, and select the appropriate
   [user type](#user-permission-levels-explained) from the **Access** drop-down.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to change user permissions.

![Select the project](../../_images/select-a-project.png)

Click the **Project Settings** link to the right of the project's title.

![Click Project Settings](../../_images/click-project-settings-link.png)

In the **Manage Users** section, look for the user whose permissions you want to
change, and select the appropriate
[user type](#user-permission-levels-explained) from the **Access** drop-down.

![Go to Manage Users, click the Access drop-down and select new permissions](../../_images/change-user-permissions-access-drop-down.png)

## Add a Tugboat bot to your team

When Tugboat posts comments to a pull request, those comments show as being made
by the user who linked Tugboat to the git repository. In practice, this means
that the person who sets up the Tugboat account will get the git provider's
notifications on pull requests; not because they're intentionally watching or
commenting on the pull requests, but because of the automated comments that
Tugboat posts as that person.

If you'd instead like those comments to show as coming from Tugboat - and free
the user who links the account from a barrage of notifications - you can add a
Tugboat bot to your team:

1. Create an account for your Tugboat bot at your preferred git provider; i.e.
   GitHub, GitLab, BitBucket.
2. Optional:
   [Download the tugboat avatar](https://dashboard.tugboat.qa/static/Tugboat_AvatarLarge.zip)
   to use for your Tugboat bot account.
3. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
4. Select the project where you want to switch to the Tugboat bot.
5. Click the **Repository Settings** link next to the repo where you want to
   switch to the Tugboat bot.
6. Scroll down to the **Provider Comments** section (GitHub Comments, GitLab
   Comments or BitBucket Comments).
7. Press the big blue **Change** button.
8. Enter the authentication details for the Tugboat bot user you created at the
   git provider.
9. Press the **OK** button.

Now, whenever Tugboat adds comments to a pull request, the comments will display
from the Tugboat bot, and the Tugboat bot's account will get any subsequent
notifications from the provider.

#### Visual Walkthrough

Create an account for your Tugboat bot at your preferred git provider; i.e.
GitHub, GitLab, BitBucket.

![Create an account for your Tugboat bot](../../_images/github-account-for-tugboat-comments.png)

Optional:
[Download the Tugboat avatar](https://dashboard.tugboat.qa/static/Tugboat_AvatarLarge.zip)
to use for your Tugboat bot account.

![Update Tugboat bot account with the Tugboat avatar](../../_images/github-account-tugboat-avatar.png)

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to switch to the Tugboat bot.

![Select the project](../../_images/select-a-project.png)

Click the **Repository Settings** link next to the repo where you want to switch
to the Tugboat bot.

![Go to Repository Settings](../../_images/go-to-repository-settings.png)

Scroll down to the **Provider Comments** section (GitHub Comments, GitLab
Comments or BitBucket Comments).

![Scroll to Provider Comments](../../_images/scroll-to-provider-comments.png)

Press the big blue **Change** button.

![Press the Change button](../../_images/provider-comments-press-the-change-button.png)

Enter the authentication details for the Tugboat bot user you created at the git
provider.

![Enter authentication details](../../_images/provider-comments-enter-authentication-details.png)

Press the **OK** button.

![Press OK](../../_images/provider-comments-press-ok-button.png)

### User permission levels explained

Tugboat has three different types of users:

- [Admin](#admin-permissions)
- [User](#user-permissions)
- [Read-only](#read-only-permissions)

#### Admin permissions

Admin users can:

- Manage billing information. This information is disabled if the company is
  paying with a purchase order.
- Manage other users, including removing other admins, though they cannot remove
  themselves.
- Add repositories to the project.
- Change repository settings.
- Delete repositories.
- Delete the entire project.
- Rename the project.

#### User permissions

Tugboat's generic User's permissions include:

- Manage the repository configuration interface. This includes things like
  [changing repository settings](../setting-up-tugboat/index.md#repository-settings-optional),
  environment variables and SSH keys.
- Manage Previews. Create, remove, rebuild, or lock Previews.
- Manage Base Previews.
- Shell access to previews. Manage visual diff screenshots. View build logs.

#### Read-only permissions

Tugboat users with Read-only permissions can:

- View a list of all Previews, see build logs and visual diff screenshots.
- Read-only users may create additional visual diff screenshots.

These users have no access to anything else.
