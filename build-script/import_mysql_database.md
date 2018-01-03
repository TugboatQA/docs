# Import a MySQL Database

This example assumes that there is a mysqldump file available somewhere via SSH,
and that MySQL is running on a service named "mysql". First, import the Tugboat
Repository's SSH public key to the server hosting the file. Then, add the
following to the repository's Makefile

```
tugboat-init:
    apt-get update
    apt-get install -y mysql-client
    scp dev.example.com/database.sql.gz /tmp/
    mysql -h mysql -u tugboat -ptugboat -e "create database tugboat;"
    zcat /tmp/database.sql.gz | mysql -h mysql -u tugboat -ptugboat tugboat
    rm /tmp/database.sql.gz
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

