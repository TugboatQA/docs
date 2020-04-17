---
title: "Change User Permissions"
date: 2019-09-26T15:15:58-04:00
lastmod: 2020-04-17T17:00:00-04:00
weight: 3
---

## Change user permissions

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to change user permissions.
3. Click the {{% ui-text %}}Project Settings{{% /ui-text %}} link to the right of the project's title.
4. In the {{% ui-text %}}Manage Users{{% /ui-text %}} section, look for the user whose permissions you want to change,
   and select the appropriate [user type](../user-admin/) from the {{% ui-text %}}Access{{% /ui-text %}} drop-down.

{{% notice info %}} There must always be an [Owner user](../user-admin/#owner-permissions) for a Tugboat project. Only
Owner users can give or remove Owner user permissions. In order to downgrade or remove an Owner user, a second user must
have Owner user permissions, and then the second Owner user can make changes to the first Owner user's
permissions.{{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to change user permissions.

![Select the project](../../_images/select-a-project.png)

Click the {{% ui-text %}}Project Settings{{% /ui-text %}} link to the right of the project's title.

![Click Project Settings](../../_images/click-project-settings-link.png)

In the {{% ui-text %}}Manage Users{{% /ui-text %}} section, look for the user whose permissions you want to change, and
select the appropriate [user type](../user-admin/) from the {{% ui-text %}}Access{{% /ui-text %}} drop-down.

![Go to Manage Users, click the Access drop-down and select new permissions](../../_images/change-user-permissions-access-drop-down.png)

{{% /expand%}}
