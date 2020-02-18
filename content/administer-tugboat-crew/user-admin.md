---
title: "User Permission Levels"
date: 2019-09-19T10:36:14-04:00
weight: 4
---

### User permission levels explained

Tugboat has three different types of users:

- [Admin](#admin-permissions)
- [User](#user-permissions)
- [Read-only](#read-only-permissions)

#### Admin permissions

Admin users can:

- Manage billing information. This information is disabled if the company is paying with a purchase order.
- Manage other users, including removing other admins, though they cannot remove themselves.
- Add repositories to the project.
- Change repository settings.
- Delete repositories.
- Delete the entire project.
- Rename the project.

#### User permissions

Tugboat's generic User's permissions include:

- Manage the repository configuration interface. This includes things like
  [changing repository settings](/setting-up-tugboat/select-repo-settings/#change-repository-settings), environment
  variables and SSH keys.
- Manage Previews. Create, remove, rebuild, or lock Previews.
- Manage Base Previews.
- Shell access to previews. Manage visual diff screenshots. View build logs.

#### Read-only permissions

Tugboat users with Read-only permissions can:

- View a list of all Previews, see build logs and visual diff screenshots.
- Read-only users may create additional visual diff screenshots.

These users have no access to anything else.
