---
title: "MySQL TLS / SSL error 2026: disabling SSL"
date: 2025-02-18T10:00:00-05:00
weight: 5
---

Newer versions of the MySQL and MariaDB client require SSL connections by default when connecting to MySQL-flavored
database services. Tugboat cannot automatically provision SSL certificates because it has no way to determine which
services in your stack require them, what certificate requirements they have, or how your applications expect them to be
configured—these decisions are specific to each application's architecture and security needs. This can cause database
connection failures during Preview builds.

You may encounter an error like:

```
ERROR 2026 (HY000): TLS/SSL error: SSL is required, but the server does not support it
```

## The Solution: Disable SSL in the MySQL Client

To resolve this issue, configure the MySQL client on your application service (typically PHP) to skip SSL verification.

### For General MySQL/MariaDB Connections

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

### For Drupal Sites Using Drush

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
              query:
                options:
                  extra: "--skip-ssl"
          EOF
        # Your other init commands...
```

The `/etc/drush/drush.yml` file tells Drush to pass the `--skip-ssl` option to the MySQL client for all SQL-related
commands including `sql:cli`, `sql:connect`, `sql:create`, `sql:drop`, `sql:dump`, and `sql:query`.
