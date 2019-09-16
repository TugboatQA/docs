# How to set up Services in Tugboat

1. [Name your Service](#name-your-service)
2. [Specify a Service Image](#specify-a-service-image)
3. [Leverage Service Commands (optional)](#leverage-service-commands-optional)
4. [Define a default Service](#define-a-default-service)
5. [Expose a Service HTTP port](#expose-a-service-http-port)
6. [Set the document Root Path](#set-the-document-root-path)
7. [Clone Git repositories into your Services](#clone-git-repositories-into-your-services)
8. [Running a Background Process (Optional)](#running-a-background-process-optional)

Want to know more about Services? Take a look at:
[What are Tugboat Services?](../index.md#what-are-tugboat-services)

## Name your Service

The top level of your
[Config file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file) is
a `services` key whose value is a list of Services.

```yaml
services:
  service1:
  service2:
  service3:
```

Service names are arbitrary, but they act as the internal host name for the
Service. This is the name other Services in the Preview would use to refer to
the Service. As a result, there are a few rules you must observe when naming
Services:

- Service names may only include the characters `a-z`, `0-9`, and `-`.
- Service names are limited to 39 characters.

As an example, a set of Services that serve a PHP-based site with a MySQL
database and a Redis cache might be:

```yaml
services:
  apache:
  mysql:
  redis:
```

## Specify a Service Image

Because Tugboat uses Docker under the hood, every Service in your config file
must use a
[valid Docker image address](https://docs.docker.com/engine/reference/commandline/pull/).

Here's what you need to know about working with Service images in Tugboat:

- [How to call a Service image from Docker Hub](#how-to-call-a-service-image-from-docker-hub)
- [How to use a Docker image from another registry](#how-to-use-a-docker-image-from-another-registry)

If you want to pull a Docker image that isn't public, you'll need to
[authenticate with the Docker Registry](../../setting-up-tugboat/index.md#authenticate-with-a-docker-registry)
from your project's
[Repository Settings](../../setting-up-tugboat/index.md#change-repository-settings).

For a deeper dive on Service images in Tugboat, check out:

- [Using Tugboat's prebuilt Docker images](../service-images/index.md#tugboats-prebuilt-docker-images)
- [Using Third-party Docker images](../service-images/index.md#third-party-docker-images)
- [Using a Docker image to mirror your production services](../service-images/index.md#using-a-docker-image-to-mirror-your-production-services)
- [When does an image get pulled or updated?](../service-images/index.md#when-does-an-image-get-pulled-or-updated)

> #### Info::New to Docker images?
>
> Tugboat has abstracted away some of the technical aspects of working with
> Docker images, but if you're new to Docker, and want to understand more about
> Docker images,
> [check out Docker's documentation](https://docs.docker.com/v17.09/engine/userguide/storagedriver/imagesandcontainers/).

### How to call a Service image from Docker Hub

Tugboat's default image registry is [Docker Hub](https://hub.docker.com/). When
you use an `image` key in the Service definition, Tugboat pulls the
corresponding image from Docker Hub.

To call a Service image from Docker Hub, specify an `image` key in the Service
definition.

For example:

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
  msyql:
    image: tugboatqa/mysql:5.6
```

To dissect the key value in our Apache image key example above, we're calling:

`tugboatqa` : Profile of the image provider on Docker Hub; in this case, it's
[TugboatQA](https://hub.docker.com/u/tugboatqa), the organization.  
`httpd` : This is the specific image we're calling; in this case, it's Tugboat's
version of the [Apache HTTP Server](https://hub.docker.com/r/tugboatqa/httpd).  
`2.4` : **OPTIONAL** version tag; in this case, we're calling for the specific
2.4 version of Tugboat's Apache HTTP server image. If you browse to the
[supported images in our GitHub repo](https://github.com/TugboatQA/dockerfiles/blob/master/httpd/TAGS.md),
you can see a list of all the version tags available for Tugboat's Apache HTTP
Server image.

For more on version tags, take a look at our
[Docker image version tags primer](../service-images/index.md#docker-image-version-tags-primer).

### How to use a Docker image from another registry

If you want to use a Docker image from another registry, you'll need to specify
the alternate registry, since Tugboat pulls from Docker Hub by default.

For a full breakdown of how to pull from a different registry, check out
Docker's Docs:
[Pull from a different registry](https://docs.docker.com/engine/reference/commandline/pull/#pull-from-a-different-registry).

An example of this in action at Tugboat might look like:

`image: registry.example.com:5000/path-to-image/httpd:2.4`

## Leverage Service Commands (optional)

While technically optional, Service Commands are arguably the most powerful part
of the
[configuration file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file).
This is the set of commands that Tugboat runs in a Service container while
creating a Preview.

The service commands are separated into a set of stages: `init`, `update`, and
`build`. Each stage represents an optional set of commands that Tugboat should
run during that stage. For more info on the stages in the Preview build process,
check out:
[the build process: explained](../../building-a-preview/how-previews-work/index.md#the-build-process-explained).

It may help to think of the stages as groups of commands with a particular
purpose. While not enforced in any way, the stages roughly represent the
following purposes:

- **init** - Run commands that set up the basic Preview infrastructure. This
  might include things like installing required packages or tools, or overriding
  default configuration files.

- **update** - Run commands that import data or other assets into a Service.
  This might include things like importing a database, or syncing image files
  into a service.

- **build** - Run commands that build or generate the actual site. This might
  include things like compiling Sass files, updating 3rd party libraries, or
  running database updates that the current code in the preview depends on.

> #### Info::Command Context
>
> Each command is run in its own context, meaning things like `cd` do not
> "stick" between commands. If that behavior is required, an external script
> should be included in the git repository and called from the config file.

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
    commands:
      init:
        - apt-get install nodejs
        - ln -snf "${TUGBOAT_ROOT}" "${DOCROOT}"
      update:
        - rsync -av example.com:files/ "${DOCROOT}/files/"
        - chgrp -R www-data "${DOCROOT}/files"
      build:
        - npm install
  mysql:
    image: tugboatqa/mysql:5.6
    commands:
      update:
        - scp example.com:mysqldump.sql.gz /tmp/
        - zcat /tmp/mysqldump.sql.gz | mysql tugboat
```

Notice that each stage is optional for a given service. There may not be any
commands required for that service during some stage. When that is the case, the
stage can be excluded completely.

## Define a default Service

Every
[Config file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file)
requires a default Service. The default Service is where HTTP requests are
routed when a [Preview's URL](../../building-a-preview/share-a-preview/index.md)
is visited by a user.

If your Config file only has one Service, that Service automatically becomes the
default Service.

If your Config file contains multiple Services, you must designate one of them
as the `default`. Specify a default Service by adding a `default` key to the
Service, with a value of `true`.

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
  mysql:
    image: tugboatqa/mysql:5.6
```

> #### Note:: Default Service behaviors
>
> Setting a Service as the `default` - including when the Service is
> automatically designated `default` because it's the only Service - also
> implies that port 80 is exposed to the Tugboat Proxy, and that the git
> repository is cloned to /var/lib/tugboat.
>
> To override the Service HTTP port, see:
> [Expose a Service HTTP port](#expose-a-service-http-port)  
> To override the git repository clone destination, see:
> [Clone Git repositories into your Services](#clone-git-repositories-into-your-services)

## Expose a Service HTTP port

Every Service in a Preview gets a unique URL. That URL is accessible if:

- An HTTP service is running on the Service, AND;
- The port is exposed to the Tugboat Proxy.

To expose a port, include an `expose` key in the Service definition with the
port number that the HTTP service is listening on.

```yaml
services:
  node:
    image: tugboatqa/node:10
    expose: 3000
```

In this example, the Tugboat Proxy forwards requests to the service's URL
through to a nodejs service running on port 3000.

There are other options that affect how the proxy routing is handled. These
advanced options can usually be left to their default settings. Check out our
[Service Attributes reference](../reference-service-attributes/index.md) for a
complete list.

> #### Note:: Default Service port
>
> When a Service is set as the `default`, port 80 is automatically exposed. You
> can override this by using the `expose` key to explicitly set an alternate
> port.

## Set the Document Root Path

Tugboat does not try to guess where your document root lives in your repository.
Likewise, it does not try to guess where a web server image expects to serve the
default document root from. This means you are responsible for making this link
in your
[configuration file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file)

Each web server image expects the document root to be in a different location.
This is a side effect of using the
[Official Docker Images](https://docs.docker.com/docker-hub/official_repos/).
The [images](../service-images/index.md#tugboats-prebuilt-docker-images)
provided by Tugboat store this document root location in an environment variable
named `$DOCROOT` for convenience.

Use this configuration to link the document root to a directory named `/docroot`
in your git repository. This works for the following images provided by Tugboat:
`tugboatqa/httpd`, `tugboatqa/nginx`, `tugboatqa/php:apache`

```yaml
services:
  apache:
    image: tugboatqa/httpd
    commands:
      init:
        - ln -snf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"
```

## Clone Git repositories into your Services

When Tugboat runs, it clones your git repository into
[your `default` Service](#define-a-default-service). Optionally, you can also
clone a copy of your git repository into other Services.

To explicitly request that a Service has access to the git repository, specify
the `checkout` key in the Service definition. This is especially useful if there
are Service-specific scripts or test data files committed to your git
repository.

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
  mysql:
    image: tugboatqa/mysql:5.6
    checkout: true
```

In this example, both the `apache` and `mysql` services get a clone of the git
repository, checked out to the git branch, tag, commit, or pull request that the
preview is created for. The path where the git repository is cloned is available
in an [environment variable](../reference-environment-variables/index.md) named
`$TUGBOAT_ROOT`.

## Running a Background Process (optional)

A long-running background process in Tugboat needs some special care. If you try
to add a background-process to your
[config file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file) in
the conventional way, Tugboat will think the Preview has not finished building,
and it will be stuck in the "building" state until it eventually times out and
fails.

> #### Info:: Services stop after the Preview builds
>
> The reason Tugboat needs to wait for all of the `build` commands to finish is
> that we stop the Services after a Preview build is finished in order to take a
> snapshot.

Our
[prebuilt images](../service-images/index.md#tugboats-prebuilt-docker-images)
use [runit](http://smarden.org/runit/) to start and manage background processes.

To add your own background process that starts when the Service starts, create a
directory in `/etc/service/yourprocessname` and a script at
`/etc/service/yourprocessname/run` to tell `runit` how to start your process.

For example, the following `run` script would start Apache:

```
#!/bin/sh
exec httpd-foreground
```

Below is an example of how you might configure a NodeJS process to start. Keep
in mind that `runit` will try to start the process as soon as the `run` script
is present in the Service directory. So, set it up after any other build steps
that it might depend on.

```yaml
services:
  node:
    image: tugboatqa/node:8
      commands:
        init:
          - mkdir -p /etc/service/node
          - echo "#!/bin/sh" > /etc/service/node/run
          - echo "npm start --prefix ${TUGBOAT_ROOT}" >> /etc/service/node/run
          - chmod +x /etc/service/node/run
```
