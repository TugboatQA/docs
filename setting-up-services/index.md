# Setting up Services in your Tugboat

First thing's first: [in the context of Tugboat, what are Services, exactly?](#what-are-tugboat-services)

Once you understand that, take a look at:

[**How to set up Services in Tugboat:**](#how-to-set-up-services-in-tugboat)
1. [Name your Service](#name-your-service)
2. [Specify a Service image](#specify-a-service-image)
3. [Define a default Service](#define-a-default-service)
4. [Expose a Service HTTP Port](#expose-a-service-http-port)
5. [Set the Document Root Path](#set-the-document-root-path)

[**Services options and reference**](#services-options-and-reference)
- [Using git options with your Service (optional)](#using-git-options-with-your-service-optional)
- [Service Commands](#service-commands)
- [Set the Document Root Path](#set-the-document-root-path)
- [Running a Background Process](#running-a-background-process)

## What are Tugboat Services?

A Tugboat Service plays the role of what a server might provide in a production environment. A service can be a web server, a database server, a cache store, etc. Services form the core of your [Config file](../setting-up-tugboat/index.md#create-a-config-file), working together to build a [Preview](../building-a-preview/index.md).

Under the cover, Tugboat Services are Docker images. This tech gives you some powerful functionality in building your services - i.e. specifying PHP 7.1 with Apache for serving Drupal 7 sites, or PHP 7.2 with Apache for serving Drupal 8 sites. For more info, check out: [Specify a Service image](#specify-a-service-image).

## How to set up Services in Tugboat
1. [Name your Service](#name-your-service)
2. [Specify a Service image](#specify-a-service-image)
3. [Define a default Service](#define-a-default-service)
4. [Expose a Service HTTP Port](#expose-a-service-http-port)

### Name your Service

The top level of your [Config file](../setting-up-tugboat/index.md#create-a-config-file) is a `services` key whose value is a list of Services.

```yaml
services:
  service1:
  service2:
  service3:
```

Service names are arbitrary, but they act as the internal host name for the Service. This is the name other Services in the Preview would use to refer to the Service. As a result, there are a few rules you must observe when naming Services:

- Service names may only include the characters `a-z`, `0-9`, and `-`.
- Service names are limited to 39 characters.

As an example, a set of Services that serve a PHP-based site with a MySQL database and a Redis cache might look like this:

```yaml
services:
  apache:
  mysql:
  redis:
```

### Specify a Service image

Because Tugboat uses Docker under the hood, every Service in your config file must use a [valid Docker image address](https://docs.docker.com/engine/reference/commandline/pull/).

Here's what you need to know about working with Service images in Tugboat:

- [How to specify a Service image in Tugboat](#how-to-specify-a-service-image)
- [Tugboat's prebuilt Docker images](#tugboats-prebuilt-docker-images)
- [Third-party Docker images](#third-party-docker-images)

> #### Info::New to Docker images?
>
> Tugboat has abstracted away some of the technical aspects of working with Docker images, but if you're new to Docker, and want to understand more about Docker images, [check out Docker's documentation](https://docs.docker.com/v17.09/engine/userguide/storagedriver/imagesandcontainers/).

#### How to specify a Service image

To configure which image a Service should use, specify an `image` key in the Service definition. For example:

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
  msyql:
    image: tugboatqa/mysql:5.6
```

To dissect this a little, in our Apache image key example above, we're calling:

`tugboatqa` : Profile of the image provider on Docker Hub. In this case, it's [TugboatQA](https://hub.docker.com/u/tugboatqa), the organization.  
`httpd` : This is the specific image we're calling; in this case, it's Tugboat's version of the [Apache HTTP Server](https://hub.docker.com/r/tugboatqa/httpd).  
`2.4` : **OPTIONAL** version tag; in this case, we're calling for the specific 2.4 version of Tugboat's Apache HTTP server image. If you browse to Docker Hub's [Tags page](https://hub.docker.com/r/tugboatqa/httpd/tags) for this image, you can see a list of all the version tags available for Tugboat's Apache HTTP Server image.

##### Image version tags

Use tags to indicate specific versions of an image, if needed. In [our example above](#how-to-specify-a-service-image), you'll note versions `2.4` or `5.6` for the `httpd` and `mysql` images.

You can specify version tags in a few different ways:

- [Point-release version tags](#point-release-version-tags)
- [Major version tags](#major-version-tags)
- [Latest version tags](#latest-version-tags)

> #### Note:: You don't have to specify a version tag
>
> If you don't need a specific version of a Service image, you can leave the tag off the image call. When you don't specify a tag, you'll get the latest version of that image.

If you're not sure which version tag to use, you can always browse to the service image on [Docker Hub](https://hub.docker.com/) and check out what tags are available.

![Browse image tags on Docker Hub](_images/browse_tags_on_docker_hub.png)

###### Point-release version tags:

Using specific version tags helps prevent breaking changes that come along with incremental updates. In our example above, we've called `tugboatqa/mysql:5.6` instead of `tugboatqa/mysql:5`.

###### Major version tags
If you want to make sure you're using a specific major version, but don't care about point releases, specify something like `tugboatqa/node:8` to ensure you always use the latest available minor release
of node 8.x.

###### Latest version tags
In some cases, you're less likely to be worried about a specific version; for example, it may not matter which version of memcached you use.

When you don't need to call for a specific version of a Service, using just the image name without a tag (`tugboatqa/memcached`), or the `latest` tag (`tugboatqa/memcached:latest`) will get you the most recent version of a Service image.

#### Tugboat's prebuilt Docker images

Tugboat maintains several [prebuilt Docker images](../reference/services/index.md). These images are
extensions of [official Docker images](https://docs.docker.com/docker-hub/official_repos/), and include tools and configurations that help them work well with Tugboat. A complete list of available images and tags can be found on [Docker Hub](https://hub.docker.com/u/tugboatqa/). The scripts used to create these images are available on [GitHub](https://github.com/TugboatQA/images).

#### Third-party Docker images

Theoretically, you can use any publicly available Docker image in your Tugboat build. However, you may run into a limitation that can make third-party Docker images problematic: Tugboat will not create a Service from an image that defines any VOLUMES. For that reason, we recommend sticking with the images built specifically for use with Tugboat.

### Define a default Service



### Expose a Service HTTP port



## Services options and reference
- Using git options with your Service (optional)
- Service Commands
- Set the Document Root Path
- Running a Background Process
