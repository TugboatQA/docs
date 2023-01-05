---
title: "Tugboat Images"
date: 2019-09-17T11:26:28-04:00
weight: 6
---

Tugboat maintains several Docker images. These images are extensions of
[official Docker images](https://docs.docker.com/docker-hub/official_repos) and include tools and configurations that
help them work well with Tugboat. Tugboat's images track the upstream images.

All of our images are available on [Docker Hub](https://hub.docker.com/u/tugboatqa/). The source code used to generate
these images is available on [GitHub](https://github.com/TugboatQA/images).

It is best practice to use the most specific tag available for a given image to prevent any unforeseen upstream changes
from affecting your Previews. For example, instead of `tugboatqa/mysql:5`, it is generally better to use
`tugboatqa/mysql:5.6`.

That said, sometimes the version of a Service doesn't really matter much. For example, it may not matter which version
of memcached you use, and you can be sure you always have the most recent version available by specifying
`tugboatqa/memcached` or `tugboatqa/memcached:latest`. See also:
[Image version tags](/setting-up-services/service-images/image-version-tags/)

| Image                             | Usage                                  |                                                                                            |
| :-------------------------------- | :------------------------------------- | ------------------------------------------------------------------------------------------ |
| [Alpine](#alpine)                 | `image: tugboatqa/alpine:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/alpine/TAGS.md)        |
| Apache                            | `image: tugboatqa/httpd:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/httpd/TAGS.md)         |
| CentOS                            | `image: tugboatqa/centos:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/centos/TAGS.md)        |
| CouchDB                           | `image: tugboatqa/couchdb:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/couchdb/TAGS.md)       |
| Debian                            | `image: tugboatqa/debian:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/debian/TAGS.md)        |
| [Elastic Search](#elastic-search) | `image: tugboatqa/elasticsearch:[TAG]` | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/elasticsearch/TAGS.md) |
| [MariaDB](#mysqlmariadbpercona)   | `image: tugboatqa/mariadb:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/mariadb/TAGS.md)       |
| Memcached                         | `image: tugboatqa/memcached:[TAG]`     | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/memcached/TAGS.md)     |
| MongoDB                           | `image: tugboatqa/mongo:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/mongo/TAGS.md)         |
| [MySQL](#mysql-mariadb-percona)   | `image: tugboatqa/mysql:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/mysql/TAGS.md)         |
| Nginx                             | `image: tugboatqa/nginx:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/nginx/TAGS.md)         |
| Node                              | `image: tugboatqa/node:[TAG]`          | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/node/TAGS.md)          |
| [Percona](#mysqlmariadbpercona)   | `image: tugboatqa/percona:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/percona/TAGS.md)       |
| [PHP](#php)                       | `image: tugboatqa/php:[TAG]`           | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/php/TAGS.md)           |
| [PostgreSQL](#postgresql)         | `image: tugboatqa/postgres:[TAG]`      | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/postgres/TAGS.md)      |
| Python                            | `image: tugboatqa/python:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/python/TAGS.md)        |
| RabbitMQ                          | `image: tugboatqa/rabbitmq:[TAG]`      | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/rabbitmq/TAGS.md)      |
| Redis                             | `image: tugboatqa/redis:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/redis/TAGS.md)         |
| Ruby                              | `image: tugboatqa/ruby:[TAG]`          | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/ruby/TAGS.md)          |
| [Solr](#solr)                     | `image: tugboatqa/solr:[TAG]`          | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/solr/TAGS.md)          |
| Traefik                           | `image: tugboatqa/traefik:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/traefik/TAGS.md)       |
| Ubuntu                            | `image: tugboatqa/ubuntu:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/ubuntu/TAGS.md)        |
| Varnish                           | `image: tugboatqa/varnish:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/main/varnish/TAGS.md)       |

---

## Additional Information

### Alpine

The Alpine image is extremely minimal by nature. Unlike the other images, it does not have any extra tools installed
except those required to use git with SSH.

### Elastic Search

The 2.x tags of this image extend the official Elast Search image on
[Docker Hub](https://hub.docker.com/_/elasticsearch/). These images are based on Debian.

The newer tags of this image extend the official Elastic Search images maintained by
[Elastic.co](https://www.docker.elastic.co/). These images are based on CentOS.

### MySQL/MariaDB/Percona

The MySQL, MariaDB, and Percona images are configured the same way. Each have a default database named `tugboat` as well
as a user named `tugboat` with a password of `tugboat`. The `tugboat` user has full access to the `tugboat` database. In
addition, the `root` database user does not have a password, but can only be used to connect to the database from the
MariaDB or MySQL service.

This means that in order to do any root-level database operations, they must be done by the commands defined for the
MySQL or MariaDB service.

```yaml
services:
  mysql:
    image: tugboatqa/mysql
    commands:
      init:
        - mysql -e "CREATE DATABASE foo;"
```

If MySQL or MariaDB daemon configuration needs to be changed, create or modify the configuration file and restart the
service ([which is managed using runit](/setting-up-services/how-to-set-up-services/running-a-background-process/)):

```
services:
  mysql:
    image: tugboatqa/mysql
    commands:
      init:
        - echo "max_allowed_packet=536870912" >> /etc/mysql/conf.d/tugboat.cnf
        - sv restart mysql
```

### PHP

#### PHP Extensions

The PHP images provided [upstream](https://hub.docker.com/_/php/) do not use apt-get to install PHP extensions. Instead,
there are helper scripts that let you install additional extensions as required. The images provided by Tugboat attempt
to balance installing the most commonly used extensions with reserving as much disk space as possible. If an extension
that you need is not installed, use `docker-php-ext-configure`, `docker-php-ext-install`, and `docker-php-ext-enable` in
your Service commands.

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

In order to keep the service containers as lean as possible, only the most basic apache modules are enabled in the
PHP/Apache images. To enable a missing module, add it with a service command

```yaml
commands:
  init:
    # Enable mod_rewrite and mod_headers
    - a2enmod rewrite headers
```

### PostgreSQL

The PostgreSQL images have a default database named `tugboat` as well as a user named `tugboat` with a password of
`tugboat`. The `tugboat` user has full access to the `tugboat` database. In addition, the default superuser password is
set to `tugboat`.

### Solr

Using the official Solr image inside of Tugboat requires creating the cores as the `solr` user.

```yaml
services:
  ...
  solr:
    image: tugboatqa/solr:8.6
    checkout: true
    commands:
      init:
        - su -s /bin/sh -c "solr create_core -c [CORE] -force" solr
```

#### Drupal and Search API Solr

The following is an example setup for use with Drupal's
[Search API Solr module](https://www.drupal.org/project/search_api_solr).

##### 1. Create a new Solr service in your Tugboat config.yml

```yaml
services:
  ...
  solr:
    image: tugboatqa/solr:8.6
    checkout: true
    commands:
      init:
        - su -s /bin/sh -c "solr create_core -c [CORE] -force" solr

      build:
        - cd "${SOLR_HOME}/[CORE]" && rm -rf conf
        - cd "${SOLR_HOME}/[CORE]" && ln -snf "${TUGBOAT_ROOT}/path/to/solr/config" conf
```

You will need to replace `[CORE]` with the name of your solr core configured in Search API Solr. You will also need to
export the `config.zip` configset from the Search API Solr module, extract the archive, and store it in version control
in your project for Tugboat to use (you also should do this for your other environments) in order to remove the
"Incompatible configset" error message in the Drupal admin UI.

The `${SOLR_HOME}` environment variable may not be available with some Solr images, in which case you would need to
hard-code the path:

```shell
cd "/opt/solr/server/solr/[CORE]" && rm -rf conf
```

##### 2. Depend on the Solr service

Make sure to add the `solr` service (or whatever you call your Solr service) to the `depends` directive under the
default application.

```yaml
  php:
    ...
    depends:
      - mysql
      - solr
```

##### 3. Configure Search API with the Solr service hostname

One way to accomplish this is to add the following to a `settings.php` file that's loaded specifically for Tugboat:

```php
$config['search_api.server.SERVER_MACHINE_NAME'] = [
  'backend_config' => [
    'connector' => 'standard',
    'connector_config' => [
      'scheme' => 'http',
      'host' => 'solr',
      'path' => '',
      'core' => [CORE], # Matches core name created in Solr setup in Tugboat config.yml
      'port' => '8983',
    ],
  ],
];
```

Note: `solr` here is the service name in `.tugboat/config.yml`. If you name your service something different, make sure
to use that service name as the host.

The Search API UI for editing the doesn't show overwritten changes. To validate the overrides, run the following
command: `drush cget search_api.server.SERVER_MACHINE_NAME --include-overridden`.
