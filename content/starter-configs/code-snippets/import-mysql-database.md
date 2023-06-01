---
title: "Import a MySQL Database"
date: 2019-09-19T10:59:51-04:00
weight: 3
---

This example assumes that there is a mysqldump file available somewhere via SSH.

First, import the Tugboat Repository's [SSH key](/setting-up-tugboat/select-repo-settings/#set-up-remote-ssh-access) to
the server hosting the file.

Then, use this snippet in your [configuration file](/setting-up-tugboat/create-a-tugboat-config-file/) to import the
database into a [service](/setting-up-services/) named "mysql".

```yaml
services:
  mysql:
    image: tugboatqa/mysql:5-debian
    commands:
      init:
        - scp example.com/database.sql.gz /tmp/
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
```
