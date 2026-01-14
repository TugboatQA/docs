---
title: "Headless Wordpress + React"
date: 2026-01-14T12:00:00-04:00
weight: 8
---

A Tugboat Preview for a headless Wordpress site with a React frontend builds and connects the Node.js, PHP, and MySQL
services, then serves the site. The Preview is accessible via the secure Tugboat URL by anyone who has the link. No need
for the viewer to configure a local environment.

This code should get you started, but you will need to customize and fill in details to get the configuration working on
your project. See also
[10 Tips for Writing Your Tugboat YAML Config](https://www.tugboatqa.com/blog/10-tips-for-writing-your-tugboat-yaml-config).

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's an example decoupled Drupal + Next.js configuration you can use as a
starting point, with comments to explain what's going on:

In this example, we assume that the frontend is located in a separate repo. In addition to this configuration, you will need to [use the Public SSH key that is on the Repository Settings page](/setting-up-tugboat/select-repo-settings/index.html#use-the-tugboat-ssh-key), and add that as a Deploy Key to the repository in GitHub/GitLab/Bitbucket.

If the frontend and backend are in the same
monorepo, but in separate directories, see also [Next.js + Drupal](/starter-configs/examples/nextjs.md).

```yaml
services:
  node:
    image: tugboatqa/node:14
    expose: 3000
    checkout: true
    depends: php
    commands:
      init:
        # Update with the frontend repo's .git URL.
        - git clone https://github.com/example.git
        - npm install -g serve
      build:
        - cd headless-wordpress-frontend && git pull
        - echo "REACT_APP_GRAPHQL_URI=$TUGBOAT_DEFAULT_SERVICE_URL/graphql" > headless-wordpress-frontend/.env.local
        - cd headless-wordpress-frontend && yarn install && yarn build
      start:
        - serve -s headless-wordpress-frontend/build -l 3000 &
  php:
    default: true
    image: tugboatqa/php:8.2-apache
    depends: mysql
    commands:
      init:
        # Install prerequisite packages
        - apt-get update
        - apt-get install -y rsync

        # Turn on URL rewriting.
        - a2enmod rewrite

        # Install PHP mysqli extension
        - docker-php-ext-install mysqli

        # Install wp-cli
        - curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        - chmod +x wp-cli.phar
        - mv wp-cli.phar /usr/local/bin/wp

        # Link the docroot
        - ln -snf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"

        # Configure wordpress to work with tugboat
        - wp --allow-root --path="${DOCROOT}" config create --dbhost=mysql --dbname=tugboat --dbuser=tugboat
          --dbpass=tugboat --force

        # Update permalinks to remove the index.php.
        - wp --allow-root --path="${DOCROOT}" option set permalink_structure /%postname%/
        - wp --allow-root --path="${DOCROOT}" rewrite flush --hard

      update:
        # Import uploads
        - tar -C /tmp -zxf uploads.tar.gz
        - rsync -av --delete /tmp/uploads/ "${TUGBOAT_ROOT}/docroot/wp-content/uploads/"

        # Cleanup
        - apt-get clean
        - rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

      build:
        - |
          set -e
          if test -z "${TUGBOAT_BASE_PREVIEW}"; then
            wp --allow-root --path="${DOCROOT}" search-replace example.com "${TUGBOAT_SERVICE_URL_HOST}" --skip-columns=guid
          else
            wp --allow-root --path="${DOCROOT}" search-replace "${TUGBOAT_BASE_PREVIEW_URL_HOST}" "${TUGBOAT_SERVICE_URL_HOST}" --skip-columns=guid
          fi
        - wp --allow-root --path="${DOCROOT}" plugin install wp-graphql --activate

      clone:
        - wp --allow-root --path="${DOCROOT}" search-replace "${TUGBOAT_BASE_PREVIEW_URL_HOST}"
          "${TUGBOAT_SERVICE_URL_HOST}" --skip-columns=guid

    urls:
      - /
      - /about/
      - /contact/
      - /tugboat-engines-typically-produce-680-to-3400-hp/

    visualdiff:
      threshold: 90

  mysql:
    image: tugboatqa/mysql:5
    checkout: true
    commands:
      update:
        - zcat database.sql.gz | mysql tugboat
```

Want to know more about something mentioned in the comments of this config file? Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Set the document root path](/setting-up-services/how-to-set-up-services/set-the-document-root-path/)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
