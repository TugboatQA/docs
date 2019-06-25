# Administering your Tugboat crew

Every ship captain needs a crew - even a tugboat! Want to add, remove or make
changes to your Tugboat team?

- [Add a user to a project](#add-a-user-to-a-project)
- [Remove a user from a project](#remove-a-user-from-a-project)
- [Change user permissions](#change-user-permissions)
- [Add a Tugboat bot to your team](#add-a-tugboat-bot-to-your-team)
- [User permission levels explained](#user-permission-levels-explained)

> #### Info::Permissions and organizing projects
>
> User permissions in Tugboat are handled on a project basis - not based on the
> repository. If you've got discrete sets of users who should not be able to
> access a specific repo; for example, you've got two repos, one containing an
> internal 'top secret' project, and one containing a front-facing static site
> that an external vendor manages; you'll want to make those different projects.

## Add a user to a project

1. Click your username in the upper right-hand corner, and go to Projects;
2. Click the **My Projects** link;
3. Select the project where you want to add the user;
4. Click the **Project Settings** link to the right of the project's title;
5. In the **Invite a User to This Project** section, add the recipient's email
   address, and select the appropriate
   [user type](#user-permission-levels-explained) from the drop-down;
6. Press the big blue **Invite** button!

MW: A screenshot of the invite email content might be nice, or at least the
email address the email is coming from in case the email goes to spam?

## Remove a user from a project

1. Click your username in the upper right-hand corner, and go to Projects;
2. Click the **My Projects** link;
3. Select the project where you want to remove the user;
4. Click the **Project Settings** link to the right of the project's title;
5. In the **Manage Users** section, look for the user you want to remove, and
   click the Remove link.

## Change user permissions

1. Click your username in the upper right-hand corner, and go to Projects;
2. Click the **My Projects** link;
3. Select the project where you want to remove the user;
4. Click the **Project Settings** link to the right of the project's title;
5. In the **Manage Users** section, look for the user whose permissions you want
   to change, and select the appropriate
   [user type](#user-permission-levels-explained) from the **Access** drop-down.

## Add a Tugboat bot to your team

By default, comments that Tugboat posts to the linked git provider account
display as the user whose credentials link the account to Tugboat. If you
instead want those comments to show as coming from Tugboat, you can add a
Tugboat bot to your team:

1. Create an account called "Tugboat Bot" at your preferred git provider; i.e.
   GitHub, GitLab, BitBucket;
2. Optional:
   [Download the tugboat avatar](https://dashboard.tugboat.qa/static/Tugboat_AvatarLarge.zip)
   to use for your Tugboat Bot account;
3. Click your username in the upper right-hand corner, and go to Projects;
4. Click the **My Projects** link;
5. Select the project where you want to switch to the Tugboat bot;
6. Click the **Repository Settings** link next to the repo where you want to
   switch to the Tugboat bot;
7. Scroll down to the **Provider Comments** section (GitHub Comments, GitLab
   Comments or BitBucket Comments);
8. Press the big blue **Change** button;
9. Enter the authentication details for the Tugboat bot user you created at the
   git provider;
10. Specify permissions, or accept the default permissions, and press the **OK**
    button.

Now, whenever Tugboat adds comments to a pull request or merge request, the
comments will display from the Tugboat bot - and the Tugboat bot will get any
subsequent notifications from the provider.

### User permission levels explained

Tugboat has three different types of users:

- [Admin](#admin-permissions)
- [User](#user-permissions)
- [Read-only](#read-only-permissions)

#### Admin permissions

Admin users can:

- Manage billing information. This information is disabled if company is paying
  with a purchase order.
- Manage other users, including removing other admins, though they cannot remove
  themselves.
- Manage the repositories that are in the project, including
  [changing repository settings](../setting-up-tugboat/index.md#select-repo-settings-optional)
  and deleting the repositories.
- Delete the entire project, and rename the project.

#### User permissions

Tugboat's generic User's permissions include:

- Manage the configuration interface. This includes things like
  [changing repository settings](../setting-up-tugboat/index.md#select-repo-settings-optional),
  environment variables and SSH keys.
- Manage previews. Create, remove, rebuild or lock previews. Manage base
  previews.
- Shell access to previews. Manage visual diff screenshots. View build logs.

#### Read-only permissions

Tugboat users with Read-only permissions can:

- View a list of all Previews, see build logs and visual diff screenshots.
- Read-only users may create additional visual diff screenshots.

These users have no access to anything else.
