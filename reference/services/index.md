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
| Apache                            | `image: tugboatqa/httpd:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/httpd/tags/)         |
| CouchDB                           | `image: tugboatqa/couchdb:[TAG]`       | [Tags](https://hub.docker.com/r/tugboatqa/couchdb/tags/)       |
| Debian                            | `image: tugboatqa/debian:[TAG]`        | [Tags](https://hub.docker.com/r/tugboatqa/debian/tags/)        |
| [Elastic Search](#elastic-search) | `image: tugboatqa/elasticsearch:[TAG]` | [Tags](https://hub.docker.com/r/tugboatqa/elasticsearch/tags/) |
| MariaDB                           | `image: tugboatqa/mariadb:[TAG]`       | [Tags](https://hub.docker.com/r/tugboatqa/mariadb/tags/)       |
| Memcached                         | `image: tugboatqa/memcached:[TAG]`     | [Tags](https://hub.docker.com/r/tugboatqa/memcached/tags/)     |
| MongoDB                           | `image: tugboatqa/mongo:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/mongo/tags/)         |
| MySQL                             | `image: tugboatqa/mysql:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/mysql/tags/)         |
| Nginx                             | `image: tugboatqa/nginx:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/nginx/tags/)         |
| Node                              | `image: tugboatqa/node:[TAG]`          | [Tags](https://hub.docker.com/r/tugboatqa/node/tags/)          |
| [PHP](#php)                       | `image: tugboatqa/php:[TAG]`           | [Tags](https://hub.docker.com/r/tugboatqa/php/tags/)           |
| Redis                             | `image: tugboatqa/redis:[TAG]`         | [Tags](https://hub.docker.com/r/tugboatqa/redis/tags/)         |
| Ubuntu                            | `image: tugboatqa/ubuntu:[TAG]`        | [Tags](https://hub.docker.com/r/tugboatqa/ubuntu/tags/)        |

---

## Additional Information

### Elastic Search

The 2.x tags of this image extend the official Elast Search image on
[Docker Hub](https://hub.docker.com/_/elasticsearch/). These images are based on
Debian.

The newer tags of this image extend the official Elastic Search images
maintained by [Elastic.co](https://www.docker.elastic.co/). These images are
based on CentOS.

### PHP

The PHP images provided [upstream](https://hub.docker.com/_/php/) do not use
apt-get to install PHP extensions. Instead, they provide helper scripts that let
you install additional extensions as required. The images provided by Tugboat
attempt to balance installing the most commonly used extensions with reserving
as much disk space as possible. If an extension that you need is not installed,
see the
[upstream documentation](https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions)
to learn about the available helper scripts, and add any required commands to
your repository config file
[init commands](../../configuring-tugboat/index.md#commands)

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
