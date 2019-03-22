# Prebuilt Service Images

Tugboat maintains several Docker images. These images are extensions of
[official Docker images](https://docs.docker.com/docker-hub/official_repos) and
include tools and configurations that help them work well with Tugboat. All of
these images are available on [Docker Hub](https://hub.docker.com/u/tugboatqa/).
The source code used to generate these images is available on
[GitHub](https://github.com/TugboatQA/images).

It is best practice to use the most specific tag available for a given image to
prevent any unforeseen upstream changes from affecting your previews. For
example, instead of `tugboatqa/mysql:5`, it is generally better to use
`tugboatqa/mysql:5.6`.

That said, sometimes the version of a service doesn't really matter much. For
example, it may not matter which version of memcached you use, and you can be
sure you always have the most recent version available by specifying
`tugboatqa/memcached` or `tugboatqa/memcached:latest`

| Image                             | Usage                                  |                                                                |
| :-------------------------------- | :------------------------------------- | -------------------------------------------------------------- |
| [Alpine](#alpine)                 | `image: tugboatqa/alpine:[TAG]`        | [Tags](https://hub.docker.com/r/tugboatqa/alpine/tags/)        |
| Apache                            | `image: tugboatqa/httpd:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/httpd/tags/)         |
| CentOS                            | `image: tugboatqa/centos:[TAG]`        | [Tags](https://hub.docker.com/r/tugboatqa/centos/tags/)        |
| CouchDB                           | `image: tugboatqa/couchdb:[TAG]`       | [Tags](https://hub.docker.com/r/tugboatqa/couchdb/tags/)       |
| Debian                            | `image: tugboatqa/debian:[TAG]`        | [Tags](https://hub.docker.com/r/tugboatqa/debian/tags/)        |
| [Elastic Search](#elastic-search) | `image: tugboatqa/elasticsearch:[TAG]` | [Tags](https://hub.docker.com/r/tugboatqa/elasticsearch/tags/) |
| [MariaDB](#mysqlmariadbpercona)   | `image: tugboatqa/mariadb:[TAG]`       | [Tags](https://hub.docker.com/r/tugboatqa/mariadb/tags/)       |
| Memcached                         | `image: tugboatqa/memcached:[TAG]`     | [Tags](https://hub.docker.com/r/tugboatqa/memcached/tags/)     |
| MongoDB                           | `image: tugboatqa/mongo:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/mongo/tags/)         |
| [MySQL](#mysqlmariadbpercona)     | `image: tugboatqa/mysql:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/mysql/tags/)         |
| Nginx                             | `image: tugboatqa/nginx:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/nginx/tags/)         |
| Node                              | `image: tugboatqa/node:[TAG]`          | [Tags](https://hub.docker.com/r/tugboatqa/node/tags/)          |
| [Percona](#mysqlmariadbpercona)   | `image: tugboatqa/percona:[TAG]`       | [Tags](https://hub.docker.com/r/tugboatqa/percona/tags/)       |
| [PHP](#php)                       | `image: tugboatqa/php:[TAG]`           | [Tags](https://hub.docker.com/r/tugboatqa/php/tags/)           |
| Redis                             | `image: tugboatqa/redis:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/redis/tags/)         |
| Solr                              | `image: tugboatqa/solr:[TAG]`          | [Tags](https://hub.docker.com/r/tugboatqa/solr/tags/)          |
| Ubuntu                            | `image: tugboatqa/ubuntu:[TAG]`        | [Tags](https://hub.docker.com/r/tugboatqa/ubuntu/tags/)        |
| Varnish                           | `image: tugboatqa/varnish:[TAG]`       | [Tags](https://hub.docker.com/r/tugboatqa/varnish/tags/)       |

---

## Additional Information

### Alpine

The Alpine image is extremely minimal by nature. Unlike the other images, it
does not have any extra tools installed except those required to use git with
SSH.

### Elastic Search

The 2.x tags of this image extend the official Elast Search image on
[Docker Hub](https://hub.docker.com/_/elasticsearch/). These images are based on
Debian.

The newer tags of this image extend the official Elastic Search images
maintained by [Elastic.co](https://www.docker.elastic.co/). These images are
based on CentOS.

### MySQL/MariaDB/Percona

The MySQL, MariaDB, and Percona images are configured the same way. Each have a
default database named `tugboat` as well as a user named `tugboat` with a
password of `tugboat`. The `tugboat` user has full access to the `tugboat`
database. In addition, the `root` database user does not have a password, but
can only be used to connect to the database from the MariaDB or MySQL service.

This means that in order to do any root-level database operations, they must be
done by the commands defined for the MySQL or MariaDB service.

```yaml
services:
  mysql:
    image: tugboatqa/mysql
    commands:
      init:
        - mysql -e "CREATE DATABASE foo;"
```

### PHP

#### PHP Extensions

The PHP images provided [upstream](https://hub.docker.com/_/php/) do not use
apt-get to install PHP extensions. Instead, there are helper scripts that let
you install additional extensions as required. The images provided by Tugboat
attempt to balance installing the most commonly used extensions with reserving
as much disk space as possible. If an extension that you need is not installed,
use `docker-php-ext-configure`, `docker-php-ext-install`, and
`docker-php-ext-enable` in your service commands.

```yaml
commands:
  init:
    # Install and enable the redis extension
    - pecl install redis
    - docker-php-ext-enable redis
```

More information about these helper scripts can be found in the
[upstream documentation](https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions).

#### Apache Modules

In order to keep the service containers as lean as possible, only the most basic
apache modules are enabled in the PHP/Apache images. To enable a missing module,
add it with a service command

```yaml
commands:
  init:
    # Enable mod_rewrite and mod_headers
    - a2enmod rewrite headers
```

---

## Legacy Images

Before hosting images on Docker Hub, Tugboat maintained its own Docker registry.
The images in this registry are still available, but are no longer maintained or
supported. Use them at your own discretion.

These images are all based on Ubuntu 14.04 LTS and do not have any tags, only
`latest`

> #### Warning::Unsupported Images
>
> These images are no longer maintained or supported. Use them at your own
> discretion

| Image                                    | Usage                                           |
| :--------------------------------------- | :---------------------------------------------- |
| Apache 2.4.7                             | `image: registry.tugboat.qa/apache`             |
| Apache 2.4.7 + PHP 5.5.9                 | `image: registry.tugboat.qa/apache-php`         |
| Apache 2.4.7 + PHP 5.5.9 + Drush 6.7.0   | `image: registry.tugboat.qa/apache-php-drupal`  |
| Apache 2.4.7 + PHP 7.0.29                | `image: registry.tugboat.qa/apache-php7`        |
| Apache 2.4.7 + PHP 7.0.29 + Drush 8.1.15 | `image: registry.tugboat.qa/apache-php7-drupal` |
| CouchDB 1.5.0                            | `image: registry.tugboat.qa/couchdb`            |
| Elastic Search 2.4.6                     | `image: registry.tugboat.qa/elasticsearch-2.4`  |
| Elastic Search 6.2.4                     | `image: registry.tugboat.qa/elasticsearch-6`    |
| MariaDB 5.5.59                           | `image: registry.tugboat.qa/mariadb`            |
| Memcached 1.4.14                         | `image: registry.tugboat.qa/memcached`          |
| MongoDB 3.0.15                           | `image: registry.tugboat.qa/mongodb`            |
| MySQL 5.5.60                             | `image: registry.tugboat.qa/mysql`              |
| MySQL 5.6.33                             | `image: registry.tugboat.qa/mysql-56`           |
| Nginx 1.4.6                              | `image: registry.tugboat.qa/nginx`              |
| Nginx 1.4.6 + PHP 5.5.9                  | `image: registry.tugboat.qa/nginx-php`          |
| Nginx 1.4.6 + PHP 7.0.29                 | `image: registry.tugboat.qa/nginx-php7`         |
| Node 5.12.0                              | `image: registry.tugboat.qa/nodejs-5`           |
| Node 6.14.2                              | `image: registry.tugboat.qa/nodejs-6`           |
| Node 8.11.1                              | `image: registry.tugboat.qa/nodejs-8`           |
| Redis 2.8.4                              | `image: registry.tugboat.qa/redis`              |
| Supervisord 3.0b2                        | `image: registry.tugboat.qa/supervisord`        |
| Ubuntu 14.04 LTS                         | `image: registry.tugboat.qa/ubuntu`             |
