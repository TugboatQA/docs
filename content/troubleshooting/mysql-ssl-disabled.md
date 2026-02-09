---
title: "MySQL Error 2026: TLS/SSL error"
date: 2025-02-18T10:00:00-05:00
weight: 5
---

Newer versions of the MariaDB client require SSL connections by default when connecting to MySQL-flavored database
services.

If you are affected by this, you may encounter an error like:

```
ERROR 2026 (HY000): TLS/SSL error: SSL is required, but the server does not support it
```

## Understanding the Issue

This error typically occurs when the MariaDB client is expecting to connect to MariaDB server 11.4 or greater. Starting
from version 11.4,
[MariaDB server enables TLS automatically](https://mariadb.com/docs/server/security/securing-mariadb/encryption/data-in-transit-encryption/securing-connections-for-client-and-server#enabling-tls-for-mariadb-server)—certificates
are generated on startup, stored only in memory, and certificate verification is enabled by default on the client side
for MitM-safe authentication plugins (mysql_native_password, ed25519, parsec).

When your client expects this automatic TLS support but connects to an incompatible MySQL server (MySQL, MariaDB < 11.4,
or Percona), the connection fails because these servers don't have TLS configured by default.

## Solutions

There are several approaches to resolve this issue, listed here in order of preference:

### Solution 1: Upgrade to MariaDB 11.4 or Greater (Recommended)

The best fix is to ensure your MySQL server is MariaDB 11.4 or greater. With this version, TLS will work out of the box
without any additional configuration needed, and the error will not occur.

In your Tugboat `config.yml`, use a MariaDB 11.4+ image for your database service:

```yaml
services:
  mysql:
    image: tugboatqa/mariadb:11.4
    # Your database configuration...
```

### Solution 2: Downgrade the MariaDB Client

If you cannot upgrade your database server but want to maintain SSL capability in the future, you can downgrade the
MariaDB client on your application service to a version that doesn't require TLS by default.

### Solution 3: Disable SSL in the MySQL Client

If you need to use an older MySQL server (MySQL, MariaDB < 11.4, or Percona) and cannot downgrade your client, you can
configure the MySQL client on your application service (typically PHP) to skip SSL verification.

#### For General MySQL/MariaDB Connections

Add an `/etc/my.cnf` configuration file to disable SSL connections. You can do this in your Tugboat `config.yml` by
adding the following command to your application service's `init` commands:

```yaml
services:
  php:
    image: tugboatqa/php:8.3-apache
    commands:
      init:
        # Disable SSL for MySQL client connections
        - echo -e '[client]\nskip-ssl = true' > /etc/my.cnf
        # Your other init commands...
```

The `/etc/my.cnf` file will contain:

```ini
[client]
skip-ssl = true
```

This configuration tells the MySQL client to skip SSL for all connections.

#### For Drupal Sites Using Drush

Drupal sites that use Drush require an additional configuration file because Drush does not respect the `/etc/my.cnf`
file. Drush passes its own `--defaults-file` option to the MySQL client, which overrides the system-wide configuration.

To address this, you can create a `/etc/drush/drush.yml` file with the following configuration:

```yaml
services:
  php:
    image: tugboatqa/php:8.3-apache
    commands:
      init:
        # Disable SSL for MySQL client connections
        - echo -e '[client]\nskip-ssl = true' > /etc/my.cnf
        # Disable SSL for Drush SQL commands
        - mkdir -p /etc/drush
        - |
          cat <<EOF > /etc/drush/drush.yml
          command:
            sql:
              cli:
                options:
                  extra: "--skip-ssl"
              connect:
                options:
                  extra: "--skip-ssl"
              create:
                options:
                  extra: "--skip-ssl"
              drop:
                options:
                  extra: "--skip-ssl"
              dump:
                options:
                  extra: "--skip-ssl"
                  extra-dump: "--skip-ssl"
              query:
                options:
                  extra: "--skip-ssl"
          EOF
        # Your other init commands...
```

The `/etc/drush/drush.yml` file tells Drush to pass the `--skip-ssl` option to the MySQL client for all SQL-related
commands including `sql:cli`, `sql:connect`, `sql:create`, `sql:drop`, `sql:dump`, and `sql:query`.
