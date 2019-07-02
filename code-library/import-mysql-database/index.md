# Import a MySQL Database

This example assumes that there is a mysqldump file available somewhere via SSH.
First import the Tugboat Repository's
[SSH key](../../concepts/repositories/index.md#ssh-keys) to the server hosting
the file. Then use this [configuration](../../configuring-tugboat/index.md) to
import the database into a [service](../../concepts/services/index.md) named
"mysql".

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
