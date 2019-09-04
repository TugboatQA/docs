# Setting up Services in your Tugboat

First thing's first:
[in the context of Tugboat, what are Services, exactly?](#what-are-tugboat-services)

**How to set up Services in Tugboat:**

Looking for a step-by-step guide to get you started configuring Services?

1. [Name your Service](how-to-set-up-services/index.md#name-your-service)
2. [Specify a Service image](how-to-set-up-services/index.md#specify-a-service-image)
3. [Leverage Service Commands (optional)](how-to-set-up-services/index.md#leverage-service-commands-optional)
4. [Define a default Service](how-to-set-up-services/index.md#define-a-default-service)
5. [Expose a Service HTTP Port](how-to-set-up-services/index.md#expose-a-service-http-port)
6. [Set the Document Root Path](how-to-set-up-services/index.md#set-the-document-root-path)
7. [Clone Git repositories into your Services](how-to-set-up-services/index.md#clone-git-repositories-into-your-services)
8. [Running a Background Process (Optional)](how-to-set-up-services/index.md#running-a-background-process-optional)

**Service Images**

For a deeper dive on Service images, take a look at:

- [Docker image version tags primer](service-images/index.md#docker-image-version-tags-primer)
- [Tugboat's Prebuilt Docker images](service-images/index.md#tugboats-prebuilt-docker-images)
- [Using a Docker image to mirror your production Services](service-images/index.md#using-a-docker-image-to-mirror-your-production-services)
- [Third-party Docker images](service-images/index.md#third-party-docker-images)
- [When does a Docker image get pulled or updated?](service-images/index.md#when-does-an-image-get-pulled-or-updated)

**Services reference**

Lists, lists, so many lists! For your reference:

- [Service Attributes](services-reference/index.md#service-attributes)
- [Environment Variables](services-reference/index.md#environment-variables)
- [Custom Environment Variables](services-reference/index.md#custom-environment-variables)
- [Tugboat's Prebuilt Service images](services-reference/index.md#tugboats-prebuilt-service-images)

## What are Tugboat Services?

A Tugboat Service plays the role of what a server might provide in a production
environment. A service can be a web server, a database server, a cache store,
etc. Services form the core of your
[Config file](../setting-up-tugboat/index.md#create-a-tugboat-config-file),
working together to build a [Preview](../building-a-preview/index.md).

Under the cover, Tugboat Services are Docker images. This tech gives you some
powerful functionality in building your services - for example, specifying a
specific PHP version when serving Drupal sites, or using an image to mirror your
production services. For more info, check out:
[Service Images](service-images/index.md).

If you want to see a sample of what Services might look like in your site, check
out: [Services example](services-in-action/index.md).
