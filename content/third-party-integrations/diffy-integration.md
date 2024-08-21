---
title: "Diffy Integration"
date: 2020-07-17T17:00:00-04:00
weight: 10
aliases:
  - /starter-configs/code-snippets/diffy-integration
---

Tugboat does not provide `visualdiffs` for pages behind authentication. If you need to generate visual diffs from pages
that are protected behind a login screen, you can set up [Diffy](https://diffy.website/) for your Tugboat Previews.
Diffy is a third-party visual diffing tool.

## Prerequisites

1. You'll need to set up the project in Diffy, and get the numeric project ID from Diffy.
2. You'll need a Diffy API key to communicate with Diffy.

## Tugboat Repository Configuration

Create Tugboat [environment variables](/setting-up-services/how-to-set-up-services/custom-environment-variables/) to
store your `DIFFY_API_KEY` and `DIFFY_PROJECT_ID`:

![Example DIFFY_API_KEY and DIFFY_PROJECT_ID as Tugboat environment variables](/_images/diffy-envvars.png)

## Tugboat config.yml

With the envvars configured in your Tugboat repository, use this snippet in your
[configuration file](/setting-up-tugboat/create-a-tugboat-config-file/) to communicate with Diffy via a
[service](/setting-up-services/) that has PHP installed.

```yaml
services:
  apache:
    commands:
      init:
        # The Diffy CLI tool requires PHP. If the service image does not have PHP
        # installed, do it here
        #- apt-get update
        #- apt-get install php-cli

        # Download the Diffy CLI tool, and authenticate. The latest version can be
        # found at https://github.com/DiffyWebsite/diffy-cli/releases
        - curl -L https://github.com/DiffyWebsite/diffy-cli/releases/download/0.1.33/diffy.phar -o /usr/local/bin/diffy
        - chmod +x /usr/local/bin/diffy
        - diffy auth:login ${DIFFY_API_KEY}

        # Clean up after apt-get, if it was used
        #- apt-get clean
        #- rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

      online:
        # If you would like to compare this service with production
        - diffy project:compare ${DIFFY_PROJECT_ID} prod custom --env2Url="${TUGBOAT_SERVICE_URL}"
          --commit-sha=${TUGBOAT_PREVIEW_SHA}

        # If you would like to compare this service with its base preview
        - |
          if [[ -n "$TUGBOAT_BASE_PREVIEW_URL" ]]; then
            diffy project:compare $DIFFY_PROJECT_ID custom custom \
              --env1Url=$TUGBOAT_BASE_PREVIEW_URL \
              --env2Url=$TUGBOAT_SERVICE_URL \
              --commit-sha=${TUGBOAT_PREVIEW_SHA}
          fi
```
