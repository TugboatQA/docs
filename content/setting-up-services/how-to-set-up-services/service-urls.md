---
title: "How to obtain service URLs for non-default services"
date: 2026-01-14T11:27:02-04:00
weight: 11
---

In a microservices or decoupled stack, you may have the need for each service to know the public URL of the other
service. For example, if you have a NextJS frontend and Drupal backend, the frontend will need to know the backend URL,
and the backend may need to know the frontend URL.

One of the Tugboat services will be the `default` service. What this means is that that service has an exposed port (80
by default). All services will then have an environment variable with the public domain name of the default service.
(See our [docs](https://docs.tugboatqa.com/reference/environment-variables/) for a list of all the environment
variables)

```bash
$TUGBOAT_DEFAULT_SERVICE_URL=https://pr381-jkm6qcfq2nutbqjrqdlo66n7zmwbnubb.tugboatqa.com/
$TUGBOAT_DEFAULT_SERVICE_URL_HOST=pr381-jkm6qcfq2nutbqjrqdlo66n7zmwbnubb.tugboatqa.com
$TUGBOAT_DEFAULT_SERVICE_URL_PROTOCOL=https
$TUGBOAT_DEFAULT_SERVICE_URL_PATH=/
```

For example, in the case of a NextJS frontend and Drupal backend, if you have the Drupal backend as the `default`
service in your config.yml, then the frontend can use the `TUGBOAT_DEFAULT_SERVICE_URL` or
`TUGBOAT_DEFAULT_SERVICE_URL_HOST` environment variables to retrieve the public URL for the Drupal backend.

Let’s say your nextjs app has a `.env.local.template` that looks something like this:

```bash
NEXT_PUBLIC_DRUPAL_BASE_URL=https://oms.lndo.site
NEXT_IMAGE_DOMAIN=oms.lndo.site
```

You could use `sed` to replace those values with the associated Drupal URL:

```bash
cat .env.local.template |
  sed -e "s@^NEXT_PUBLIC_DRUPAL_BASE_URL=.*\$@NEXT_PUBLIC_DRUPAL_BASE_URL=${TUGBOAT_DEFAULT_SERVICE_URL}@" \
      -e "s@^NEXT_IMAGE_DOMAIN=.*\$@NEXT_IMAGE_DOMAIN=${TUGBOAT_DEFAULT_SERVICE_URL_HOST}@" \
  > .env.local
```

In config.yml, that might look like this:

```yaml
services:
  storybook:
    ...
    commands:
      ...
      build:
        - cat path/to/.env.local.template |
            sed -e "s@^NEXT_PUBLIC_DRUPAL_BASE_URL=.*\$@NEXT_PUBLIC_DRUPAL_BASE_URL=${TUGBOAT_DEFAULT_SERVICE_URL}@"
                -e "s@^NEXT_IMAGE_DOMAIN=.*\$@NEXT_IMAGE_DOMAIN=${TUGBOAT_DEFAULT_SERVICE_URL_HOST}@"
            > path/to/.env.local
```

## How to retrieve a non-default URL from another service

You may also need to know the public URL for another service that is not the default service. In this instance, you can
use the [Tugboat API](https://api.tugboatqa.com) with `curl` and `jq` to determine the URL of the other service.

Using our same example above, let’s say the Drupal backend needs to know the public URL for the frontend application.
From within the Tugboat `config.yml`, you may have something like this:

```yaml
services:
  drupal:
    image: tugboatqa/php:8.3-apache
    default: true
    commands: ...
  storybook:
    image: tugboatqa/node:18
    expose: 3000
    checkout: true
    depends:
      - drupal
    commands: ...
```

Since the `storybook` nodejs service is exposing port 3000 to the Tugboat proxy, it will receive a public URL. From the
`drupal` service, you can use the `$TUGBOAT_SERVICE_TOKEN` environment variable as
[Token-based authentication to the Tugboat API](https://api.tugboatqa.com/v3#tag/Previews/paths/~1previews~1%7Bid%7D~1services/get)
to retrieve the URL of the other service:

In a Terminal on the `drupal` service, you could test this out with the following command:

```bash
# Install jq
apt-get update && apt-get install -y jq

# Curl the API and retrieve the public storybook URL
curl --silent --header "Authorization: Token $TUGBOAT_SERVICE_TOKEN" \
  https://api.tugboatqa.com/v3/previews/$TUGBOAT_PREVIEW_ID/services |
  jq -r '.[] | select(.name == "storybook") | .urls[0]'
```

You might translate that into a `config.yml` like so:

```yaml
services:
  drupal:
    ...
    commands:
      init:
        # Install jq in the init steps
        - apt-get update && apt-get install jq
        ...

      build:
        # Use yaml literal notation to support multiline commands
        - |
          set -e
          STORYBOOK_URL=$(curl --silent -H "Authorization: Token $TUGBOAT_SERVICE_TOKEN"
            https://api.tugboatqa.com/v3/previews/$TUGBOAT_PREVIEW_ID/services |
            jq -r '.[] | select(.name == "storybook") | .urls[0]')
          # Run command to use the STORYBOOK_URL in Drupal settings.php
          printf "\$settings['YOUR_VARIABLE'] = '%s';\n" "$STORYBOOK_URL" >> path/to/settings.local.php
```

We use yaml [**literal**](https://yaml-multiline.info) notation (the pipe `|` turns this on) to allow multiline yaml
commands so we can store the storybook url into a temporary environment variable. Then we are appending a Drupal
settings.php file with a Drupal setting with that URL. You might prefer to use `sed` or some other means to achieve
this.

Tugboat provides flexible solutions for service-to-service communication in complex environments. By leveraging
environment variables and the Tugboat API, you can easily configure your services to communicate with each other,
whether they're default or non-default services. These approaches ensure that your microservices or decoupled
applications can reliably find and connect to each other, maintaining proper functionality in your Tugboat preview
environments. With the techniques outlined in this document, you can confidently set up communication between your
various services, enabling comprehensive testing and development in isolated environments that closely mirror your
production setup. If you have any questions on how to adapt this to your needs, please reach out to
[Tugboat Support](https://www.tugboatqa.com/support).
