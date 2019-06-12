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
