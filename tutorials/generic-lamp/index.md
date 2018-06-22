# Generic LAMP

A Generic LAMP stack should work with most PHP/MySQL web applications. Some
customizations may be required, but this should get you started.

## Tugboat Configuration

Let's start with the complete working configuration. This file needs to reside
in `.tugboat/config.yml` in the root of your git repository. From there, we will
step through it to explain what is going on. Then, you can customize it as
needed.

```yaml
services:
  php:
    image: tugboatqa/php-apache
    default: true
    commands:
      init:
    	- ln -sf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"

  mysql:
    image: tugboatqa/mysql
    commands:
      update:
        - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
```

### PHP Service

We chose to use PHP 7.1 with Apache.
[Other options are available](../../reference/services/index.md#php). By not
specifying a PHP version, we will always get the latest version of PHP
available. If your application requires a specific version, you should include
that here.

```yaml
image: tugboatqa/php-apache
```

This is the service that will be serving the application, so we tell Tugboat
that this is the preview's default service. This is a shortcut option to clone
the git repository into this service, and expose port 80 to the Tugboat proxy
server. It also means that the default preview URL will route to this service.

```yaml
default: true
```

Finally, we define the commands that get run on this service. The `init`
commands link the document root to the expected path.

```yaml
init:
  - ln -sf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"
```

### MySQL Service

We chose to use the latest available version of MySQL because we are not picky
about which version we get.
[Other options are available](../../reference/services/index.md#mysql)

```yaml
image: tugboatqa/mysql
```

This is an auxiliary service for a preview, so there are no additional
configurations required like we used in the PHP service. All that is left is the
commands to import the database.

We are using `scp` to copy a database dump into the mysql service container.
Before this will work, the public SSH key found in the Tugboat Repository
configuration needs to be copied to the server hosting this file.

```yaml
update:
  - scp user@example.com:database.sql.gz /tmp/database.sql.gz
  - zcat /tmp/database.sql.gz | mysql tugboat
  - rm /tmp/database.sql.gz
```

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you
can start building previews!
