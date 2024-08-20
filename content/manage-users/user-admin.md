---
title: "User Permission Levels"
date: 2019-09-19T10:36:14-04:00
lastmod: 2020-04-17T17:00:00-04:00
weight: 4
aliases:
  - "/administer-tugboat-crew/user-admin"
---

### User permission levels explained

Tugboat has four different types of users:

- [Owner](#owner-permissions)
- [Admin](#admin-permissions)
- [User](#user-permissions)
- [Read-only](#read-only-permissions)

#### Owner permissions

Owner users can:

- Manage billing information. This information is disabled if the company is paying with a purchase order.

Owners can also do everything the [admin user](#admin-permissions) and [general user](#user-permissions) can do.

#### Admin permissions

Admin users can:

- Add and remove users from a project, and change user permissions. Admin users can administer other admin users, though
  they cannot remove themselves from a project.
- Add repositories to the project.
- Manage the repository configuration interface. This includes things like
  [changing repository settings](/setting-up-tugboat/select-repo-settings/#change-repository-settings), environment
  variables and SSH keys.
- Delete repositories.
- Delete the entire project.
- Rename the project.

Admin can also do everything the [general user](#user-permissions) can do.

#### User permissions

Tugboat's general User's permissions include:

- View the repository configuration interface. This includes things like
  [repository settings](/setting-up-tugboat/select-repo-settings/#change-repository-settings), environment variables and
  SSH keys.
- Manage Previews. Create, remove, rebuild, or lock Previews.
- Manage Base Previews.
- Shell access to previews. Manage visual diff screenshots. View build logs.

#### Read-only permissions

Tugboat users with Read-only permissions can:

- View a list of all Previews, see build logs and visual diff screenshots.
- Read-only users may create additional visual diff screenshots.

These users have no access to anything else.
