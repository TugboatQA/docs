# Configuring Tugboat

Configuring a Tugboat repository consists of committing a YAML configuration
file into its git repository. This file is located at `.tugboat/config.yml`, and
configures how Tugboat builds the services for a preview and how the web site in
a preview is served. This document walks through the structure of this
configuration file, and how each of the parts work together.

This configuration file in the git repository is required. Without it, Tugboat
cannot create previews for a repository.

## Preview Services

A Tugboat preview consists of one or more services, each responsible for a
specific role in serving the web site hosted by the preview. The top level of
the configuration file is a `services` key whose value is a list of services.

```yaml
services:
  service1:
  service2:
  service3:
```

These service names are arbitrary, and can be anything you would like. Keep in
mind that they also act as the internal host name that a service is known by to
the other services in a preview. This means that the service names must conform
to the same rules as an internet host name, consisting of only the characters
`a-z`, `0-9`, and `-`.

A practical example of a set of services that might be used to serve a PHP-based
site with a MySQL database and a Redis cache might look like the following:

```yaml
services:
  apache:
  mysql:
  redis:
```

## Service Images

The only required attribute of a given service is the image it is created from.
Tugboat uses Docker under the hood, but this is the only place where that is
immediately apparent. A service image must be a
[valid Docker image address](https://docs.docker.com/engine/reference/commandline/pull/).

Tugboat maintains several
[prebuilt Docker images](../reference/services/index.md). These images are
extensions of
[official Docker images](https://docs.docker.com/docker-hub/official_repos/),
and include tools and configurations that help them work well with Tugboat. A
complete list of available images and tags can be found on
[Docker Hub](https://hub.docker.com/u/tugboatqa/). The scripts used to create
these images are available on [GitHub](https://github.com/TugboatQA/images).

> #### Info::3rd Party Docker Images
>
> Technically, any publicly available Docker image can be used. However, there
> are some limitations. For example, Tugboat will not create a service from an
> image that defines any VOLUMES. For that reason, sticking with the images
> built specifically for use with Tugboat is recommended.

To configure which image a service should use, include an `image` key in the
service definition.

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
  msyql:
    image: tugboatqa/mysql:5.6
```

Notice that a specific version of an image is indicated by the tag. Versions
`2.4` or `5.6` for the `httpd` and `mysql` images above, respectively. Selecting
the right tag is important when configuring a service image. The images provided
by Tugboat track the upstream images, meaning the `tugboat/httpd:2.4` image
extends the latest official `httpd:2.4` image.

To ensure you always have the expected version of a specific service, and to
prevent any unexpected changes to an image from breaking your previews, you
should always use the most specific tag that makes sense for your repository.
For example, instead of using `tugboatqa/mysql:5`, it is generally better to use
`tugboatqa/mysql:5.6`.

That said, sometimes the specific version of a service doesn't really matter
much. For example, it may not matter which version of memcached you use, and you
can be sure you always use the most recent version by specifying
`tugboatqa/memcached` or `tugboatqa/memcached:latest`.

Likewise, a specific major version might be sufficient. For example, specifying
`tugboatqa/node:8` will ensure you always use the latest available minor release
of node 8.x.

## Default Service

If more than one service is defined, one of them must be designated as the
`default`. If only one service is defined, it is automatically set as the
default. The default service is where HTTP requests are routed when a preview's
URL is visited by a user.

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
  mysql:
    image: tugboatqa/mysql:5.6
```

Setting a service as the default also implies that port 80 is exposed to the
Tugboat Proxy, and that the git repository is cloned to `/var/lib/tugboat`.
These implied settings can be overridden as explained below.

## Service HTTP Port

Every service in a preview is given a unique URL. Whether that URL is accessible
is determined by whether an HTTP service is running on the service, and that
port is exposed to the Tugboat Proxy. To expose a port, include an `expose` key
to the service definition with the port number that the HTTP service is
listening on.

```yaml
services:
  node:
    image: tugboatqa/node:8
    expose: 3000
```

The above configuration allows the Tugboat Proxy to forward requests to the
service's URL through to a nodejs service running on port 3000. When a service
is set as the `default`, port 80 is automatically exposed. This can be
overridden by explicitly setting an alternate port.

There are other options that affect how the proxy routing is handled. These
advanced options can usually be left to their default settings. Look through the
[Tugboat Configuration File](../reference/tugboat-configuration/index.md)
reference for a complete list.

## Git Options

Every service has the option of whether to have a copy of the git repository
cloned into it. The default behavior is to only clone the git repository into
the `default` service, as described above.

To explicitly request that a service has access to the git repository, specify
the `checkout` key in the service definition. This is especially useful if there
are service-specific scripts or test data files committed to the git repository.

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
  mysql:
    image: tugboatqa/mysql:5.6
    checkout: true
```

The above results in both the `apache` and `mysql` services getting a clone of
the git repository, checked out to the git branch, tag, commit, or pull request
that the preview is created for. The path where the git repository is cloned is
available in an
[environment variable](../reference/environment-variables/index.md) named
`$TUGBOAT_ROOT`

## Commands

TODO: explain the stage workflow

## Advanced Options

There are a number of advanced options available that were not covered here. See
the [Tugboat Configuration File](../reference/tugboat-configuration/index.md)
reference for a complete list of configuration options.

## Examples

To see some real-world example configurations, check out our tutorials

* [Static HTML](../tutorials/static-html/index.md)
* [Generic LAMP](../tutorials/generic-lamp/index.md)
* [Drupal 7](../tutorials/drupal7/index.md)
* [Drupal 8](../tutorials/drupal8/index.md)
* [WordPress](../tutorials/wordpress/index.md)
* [Pantheon](../tutorials/pantheon/index.md)
