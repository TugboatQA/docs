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
a-z, 0-9, and hyphens.

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
[Docker Hub](https://hub.docker.com/u/tugboatqa/).

> #### Info::3rd Party Docker Images
>
> Technically, any publicly available Docker image can be used. However, there
> are some limitations. For example, Tugboat will not create a service from an
> image that defines any VOLUMES. For that reason, sticking with the images
> provided by Tugboat is recommended. The scripts used to create these images
> are available on [GitHub](https://github.com/TugboatQA/images).

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

* TODO: command execution order for build/rebuild/refresh
