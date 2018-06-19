# Prebuilt Service Images

Tugboat maintains several Docker images. These images are extensions of
[official Docker images](https://docs.docker.com/docker-hub/official_repos) and
include tools and configurations that help them work well with Tugboat. All of
these images are available on [Docker Hub](https://hub.docker.com/u/tugboatqa/).
The source code used to generate these images is available on
[GitHub](https://github.com/TugboatQA/images).

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

## Apache

**Usage**

```yaml
image: tugboatqa/httpd:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/httpd/tags/)

* `2.4.33`, `2.4`, `2`, `latest`

## CouchDB

**Usage:**

```yaml
image: tugboatqa/couchdb:[TAG]
```

**Latest Tags:**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/couchdb/tags/)

* `2.1.1`, `2.1`, `2`, `latest`
* `1.7.1`, `1.7`, `1`

## Debian

**Usage**

```yaml
image: tugboatqa/debian:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/debian/tags/)

* `9.4`, `9`, `stretch`, `latest`
* `8.10`, `8`, `jessie`

## Elastic Search

**Usage**

```yaml
image: tugboatqa/elasticsearch:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/elasticsearch/tags/)

The 2.x tags extend the
[images maintained by Docker Hub](https://hub.docker.com/_/elasticsearch/),
which are based on Debian. The newer tags extend the
[images maintained by Elastic.co](https://www.docker.elastic.co/), which are
based on CentOS.

* `6.2.4`, `6.2`, `6`, `latest`
* `6.1.4`, `6.1`
* `6.0.1`, `6.0`
* `5.6.9`, `5.6`, `5`
* `5.5.3`, `5.5`
* `5.4.3`, `5.4`
* `2.4.6`, `2.4`, `2`

## MariaDB

**Usage**

```yaml
image: tugboatqa/mariadb:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/mariadb/tags/)

* `10.3.7`, `10.3`, `10`, `latest`
* `10.2.15`, `10.2`
* `10.1.33`, `10.1`
* `10.0.35`, `10.0`
* `5.5.60`, `5.5`, `5`

## Memcached

**Usage**

```yaml
image: tugboatqa/memcached:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/memcached/tags/)

* `1.5.8`, `1.5`, `1`, `latest`

## MongoDB

**Usage**

```yaml
image: tugboatqa/mongo:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/mongo/tags/)

* `3.6.5`, `3.6`, `3`, `latest`
* `3.4.15`, `3.4`
* `3.2.20`, `3.2`

## MySQL

**Usage**

```yaml
image: tugboatqa/mysql:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/mysql/tags/)

* `8.0.11`, `8.0`, `8`, `latest`
* `5.7.22`, `5.7`, `5`
* `5.6.40`, `5.6`
* `5.5.60`, `5.5`

## Nginx

**Usage**

```yaml
image: tugboatqa/nginx:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/nginx/tags/)

* `1.15.0`, `mainline`, `1`, `1.15`, `latest`
* `1.15.0-perl`, `mainline-perl`, `1-perl`, `1.15-perl`, `perl`
* `1.14.0`, `stable`, `1.14`
* `1.14.0-perl`, `stable-perl`, `1.14-perl`

## Node

**Usage**

```yaml
image: tugboatqa/node:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/node/tags/)

* `10.4.0-jessie`, `10.4-jessie`, `10-jessie`, `jessie`, `10.4.0`, `10.4`, `10`,
  `latest`
* `10.4.0-stretch`, `10.4-stretch`, `10-stretch`, `stretch`
* `9.11.1-jessie`, `9.11-jessie`, `9-jessie`, `9.11.1`, `9.11`, `9`
* `9.11.1-stretch`, `9.11-stretch`, `9-stretch`
* `8.11.2-jessie`, `8.11-jessie`, `8-jessie`, `carbon-jessie`, `8.11.2`, `8.11`,
  `8`, `carbon`
* `8.11.2-stretch`, `8.11-stretch`, `8-stretch`, `carbon-stretch`
* `6.14.2-jessie`, `6.14-jessie`, `6-jessie`, `boron-jessie`, `6.14.2`, `6.14`,
  `6`, `boron`
* `6.14.2-stretch`, `6.14-stretch`, `6-stretch`, `boron-stretch`

## PHP

**Usage**

```yaml
image: tugboatqa/php:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/php/tags/)

* `7.2.6-fpm-stretch`, `7.2-fpm-stretch`, `7-fpm-stretch`, `fpm-stretch`,
  `7.2.6-fpm`, `7.2-fpm`, `7-fpm`, `fpm`
* `7.2.6-apache-stretch`, `7.2-apache-stretch`, `7-apache-stretch`,
  `apache-stretch`, `7.2.6-apache`, `7.2-apache`, `7-apache`, `apache`
* `7.1.18-fpm-stretch`, `7.1-fpm-stretch`, `7.1.18-fpm`, `7.1-fpm`
* `7.1.18-fpm-jessie`, `7.1-fpm-jessie`
* `7.1.18-apache-stretch`, `7.1-apache-stretch`, `7.1.18-apache`, `7.1-apache`
* `7.1.18-apache-jessie`, `7.1-apache-jessie`
* `7.0.30-fpm-stretch`, `7.0-fpm-stretch`, `7.0.30-fpm`, `7.0-fpm`
* `7.0.30-fpm-jessie`, `7.0-fpm-jessie`
* `7.0.30-apache-stretch`, `7.0-apache-stretch`, `7.0.30-apache`, `7.0-apache`
* `7.0.30-apache-jessie`, `7.0-apache-jessie`
* `5.6.36-fpm-stretch`, `5.6-fpm-stretch`, `5-fpm-stretch`, `5.6.36-fpm`,
  `5.6-fpm`, `5-fpm`
* `5.6.36-fpm-jessie`, `5.6-fpm-jessie`, `5-fpm-jessie`
* `5.6.36-apache-stretch`, `5.6-apache-stretch`, `5-apache-stretch`,
  `5.6.36-apache`, `5.6-apache`, `5-apache`
* `5.6.36-apache-jessie`, `5.6-apache-jessie`, `5-apache-jessie`

## Ubuntu

**Usage**

```yaml
image: tugboatqa/ubuntu:[TAG]
```

**Latest Tags**

Full list available at
[Docker Hub](https://hub.docker.com/r/tugboatqa/ubuntu/tags/)

* `18.04`, `bionic-20180526`, `bionic`, `latest`
* `17.10`, `artful-20180524`, `artful`
* `16.04`, `xenial-20180525`, `xenial`
* `14.04`, `trusty-20180531`, `trusty`
