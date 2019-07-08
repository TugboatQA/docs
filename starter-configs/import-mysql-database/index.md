# Import a MySQL Database

This example assumes that there is a mysqldump file available somewhere via SSH.
First import the Tugboat Repository's
[SSH key](../../setting-up-tugboat/index.md#set-up-remote-ssh-access) to the
server hosting the file. Then use this snippet in your
[configuration file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file)
to import the database into a [service](../../setting-up-services/index.md)
named "mysql".

```yaml
services:
  mysql:
    image: tugboatqa/mysql
    commands:
      init:
        - scp example.com/database.sql.gz /tmp/
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
```
