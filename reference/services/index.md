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

## Images

* [Apache](#apache)
* [CouchDB](#couchdb)
* [Debian](#debian)
* [Elastic Search](#elastic-search)
* [MariaDB](#mariadb)
* [Memcached](#memcached)
* [MongoDB](#mongodb)
* [MySQL](#mysql)
* [Nginx](#nginx)
* [Node](#node)
* [PHP](#php)
* [Ubuntu](#ubuntu)

### Apache

* **Usage:** `image: tugboatqa/httpd:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/httpd/tags/
* **Upstream:** https://hub.docker.com/_/httpd/

## CouchDB

* **Usage:** `image: tugboatqa/couchdb:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/couchdb/tags/
* **Upstream:** https://hub.docker.com/_/couchdb/

## Debian

* **Usage** `image: tugboatqa/debian:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/debian/tags/
* **Upstream:** https://hub.docker.com/_/debian/

## Elastic Search

* **Usage:** `image: tugboatqa/elasticsearch:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/elasticsearch/tags/
* **Upstream:** https://hub.docker.com/_/elasticsearch/ and
  https://www.docker.elastic.co/

The 2.x tags extend the
[images maintained by Docker Hub](https://hub.docker.com/_/elasticsearch/),
which are based on Debian. The newer tags extend the
[images maintained by Elastic.co](https://www.docker.elastic.co/), which are
based on CentOS.

## MariaDB

* **Usage:** `image: tugboatqa/mariadb:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/mariadb/tags/
* **Upstream:** https://hub.docker.com/_/mariadb/

## Memcached

* **Usage:** `image: tugboatqa/memcached:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/memcached/tags/
* **Upstream:** https://hub.docker.com/_/memcached/

## MongoDB

* **Usage: ** `image: tugboatqa/mongo:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/mongo/tags/
* **Upstream:** https://hub.docker.com/_/mongo/

## MySQL

* **Usage** `image: tugboatqa/mysql:[TAG]`
* **Tags: ** https://hub.docker.com/r/tugboatqa/mysql/tags/
* **Upstream:** https://hub.docker.com/_/mysql/

## Nginx

* **Usage:** `image: tugboatqa/nginx:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/nginx/tags/
* **Upstream:** https://hub.docker.com/_/nginx/

## Node

* **Usage:** `image: tugboatqa/node:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/node/tags/
* **Upstream:** https://hub.docker.com/_/node/

## PHP

* **Usage:** `image: tugboatqa/php:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/php/tags/
* **Upstream:** https://hub.docker.com/_/php/

## Ubuntu

* **Usage:** `image: tugboatqa/ubuntu:[TAG]`
* **Tags:** https://hub.docker.com/r/tugboatqa/ubuntu/tags/
* **Upstream:** https://hub.docker.com/_/ubuntu/
