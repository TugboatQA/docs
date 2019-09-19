# Tugboat's Prebuilt Service images

Tugboat maintains several Docker images. These images are extensions of
[official Docker images](https://docs.docker.com/docker-hub/official_repos) and
include tools and configurations that help them work well with Tugboat.
Tugboat's images track the upstream images.

All of our images are available on
[Docker Hub](https://hub.docker.com/u/tugboatqa/). The source code used to
generate these images is available on
[GitHub](https://github.com/TugboatQA/images).

It is best practice to use the most specific tag available for a given image to
prevent any unforeseen upstream changes from affecting your Previews. For
example, instead of `tugboatqa/mysql:5`, it is generally better to use
`tugboatqa/mysql:5.6`.

That said, sometimes the version of a Service doesn't really matter much. For
example, it may not matter which version of memcached you use, and you can be
sure you always have the most recent version available by specifying
`tugboatqa/memcached` or `tugboatqa/memcached:latest`. See also:
[Image version tags](../service-images/index.md#docker-image-version-tags-primer)

| Image                             | Usage                                  |                                                                                              |
| :-------------------------------- | :------------------------------------- | -------------------------------------------------------------------------------------------- |
| [Alpine](#alpine)                 | `image: tugboatqa/alpine:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/alpine/TAGS.md)        |
| Apache                            | `image: tugboatqa/httpd:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/httpd/TAGS.md)         |
| CentOS                            | `image: tugboatqa/centos:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/centos/TAGS.md)        |
| CouchDB                           | `image: tugboatqa/couchdb:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/couchdb/TAGS.md)       |
| Debian                            | `image: tugboatqa/debian:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/debian/TAGS.md)        |
| [Elastic Search](#elastic-search) | `image: tugboatqa/elasticsearch:[TAG]` | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/elasticsearch/TAGS.md) |
| [MariaDB](#mysqlmariadbpercona)   | `image: tugboatqa/mariadb:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/mariadb/TAGS.md)       |
| Memcached                         | `image: tugboatqa/memcached:[TAG]`     | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/memcached/TAGS.md)     |
| MongoDB                           | `image: tugboatqa/mongo:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/mongo/TAGS.md)         |
| [MySQL](#mysqlmariadbpercona)     | `image: tugboatqa/mysql:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/mysql/TAGS.md)         |
| Nginx                             | `image: tugboatqa/nginx:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/nginx/TAGS.md)         |
| Node                              | `image: tugboatqa/node:[TAG]`          | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/node/TAGS.md)          |
| [Percona](#mysqlmariadbpercona)   | `image: tugboatqa/percona:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/percona/TAGS.md)       |
| [PHP](#php)                       | `image: tugboatqa/php:[TAG]`           | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/php/TAGS.md)           |
| Redis                             | `image: tugboatqa/redis:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/redis/TAGS.md)         |
| Solr                              | `image: tugboatqa/solr:[TAG]`          | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/solr/TAGS.md)          |
| Ubuntu                            | `image: tugboatqa/ubuntu:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/ubuntu/TAGS.md)        |
| Varnish                           | `image: tugboatqa/varnish:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/varnish/TAGS.md)       |

---

### Additional Information

#### Alpine

The Alpine image is extremely minimal by nature. Unlike the other images, it
does not have any extra tools installed except those required to use git with
SSH.

#### Elastic Search

The 2.x tags of this image extend the official Elast Search image on
[Docker Hub](https://hub.docker.com/_/elasticsearch/). These images are based on
Debian.

The newer tags of this image extend the official Elastic Search images
maintained by [Elastic.co](https://www.docker.elastic.co/). These images are
based on CentOS.

#### MySQL/MariaDB/Percona

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

#### PHP

##### PHP Extensions

The PHP images provided [upstream](https://hub.docker.com/_/php/) do not use
apt-get to install PHP extensions. Instead, there are helper scripts that let
you install additional extensions as required. The images provided by Tugboat
attempt to balance installing the most commonly used extensions with reserving
as much disk space as possible. If an extension that you need is not installed,
use `docker-php-ext-configure`, `docker-php-ext-install`, and
`docker-php-ext-enable` in your Service commands.

```yaml
commands:
  init:
    # Install and enable the redis extension
    - pecl install redis
    - docker-php-ext-enable redis
```

More information about these helper scripts can be found in the
[upstream documentation](https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions).

##### Apache Modules

In order to keep the service containers as lean as possible, only the most basic
apache modules are enabled in the PHP/Apache images. To enable a missing module,
add it with a service command

```yaml
commands:
  init:
    # Enable mod_rewrite and mod_headers
    - a2enmod rewrite headers
```
