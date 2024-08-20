---
title: "Add a User"
date: 2019-09-26T15:15:25-04:00
weight: 1
aliases:
  - "/administer-tugboat-crew/add-a-user"
---

## To add a user to a project

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to add the user.
3. Click the {{% ui-text %}}Project Settings{{% /ui-text %}} link to the right of the project's title.
4. In the {{% ui-text %}}Invite a User to This Project{{% /ui-text %}} section, add the recipient's email address, and
   select the appropriate [user type](../user-admin/) from the drop-down.
5. Press the big blue {{% ui-text %}}Invite{{% /ui-text %}} button!

The user you've invited will get an email from `support@tugboatqa.com` with a link to accept the invitation.

{{% notice info %}} User permissions in Tugboat are handled on a per-project basis. When users have access to a project,
they have access to all the repositories within that project. When inviting users to your project, consider whether any
of your repos contain sensitive data; you may want to split those repos out into a different project, where only a
subset of users get access. {{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to add the user.

![Select the project](../../_images/select-a-project.png)

Click the {{% ui-text %}}Project Settings{{% /ui-text %}} link to the right of the project's title.

![Click Project Settings](../../_images/click-project-settings-link.png)

In the {{% ui-text %}}Invite a User to This Project{{% /ui-text %}} section, add the recipient's email address, and
select the appropriate [user type](../user-admin/) from the drop-down.

![Add user's email address and select permissions](../../_images/add-user-email-and-permissions.png)

Press the big blue {{% ui-text %}}Invite{{% /ui-text %}} button!

![Press the Invite button](../../_images/add-user-press-invite-button.png)

{{% /expand%}}

### User doesn't see Tugboat invite

If the user doesn't see the Tugboat invite:

- Have them check Inboxes and Spam for this email address, or;
- {{% ui-text %}}Copy Link{{% /ui-text %}} and share it another way from the Pending Invites section of the Project
  Settings, or;
- Hit the {{% ui-text %}}Re-send{{% /ui-text %}} link from the Pending Invites section of the Project Settings.

![Copy Link or Re-Send from Pending Invites](../../_images/add-user-copy-link-resend.png)
