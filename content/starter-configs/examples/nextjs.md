---
title: "Next.js + Drupal"
date: 2026-01-13T12:00:00-04:00
weight: 8
---

A Tugboat Preview for a decoupled site with [Drupal](https://drupal.org/) powering the backend and
[Next.js](https://nextjs.org/) powering the front-end, builds the builds and connects the PHP, Node.js, and MariaDB
services and then serves the site. The Preview is accessible via the secure Tugboat URL by anyone who has the link. No
need for the viewer to configure a local environment.

This configuration and the accompanying Next.js config example addresses out-of-memory problems a project like this may encounter. This code should get you started, but you will need to customize and fill in details to get the
configuration working on your project. See also
[10 Tips for Writing Your Tugboat YAML Config](https://www.tugboatqa.com/blog/10-tips-for-writing-your-tugboat-yaml-config).

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's an example decoupled Drupal + Next.js configuration you can use as a
starting point, with comments to explain what's going on:

```yaml
# Next.js front end in `front-end` directory.
# Drupal back end in `back-end` directory.

services:
  php:
    image: tugboatqa/php:8.3-apache
    default: true
    depends: mysql

    commands:
      init:
        - ln -snf "${TUGBOAT_ROOT}/back-end/web" "${DOCROOT}"
        - ln -snf "${TUGBOAT_ROOT}/.tugboat/settings.local.php" "${DOCROOT}/sites/default/"

        - apt-get update
        - apt-get install -y libzip-dev
        - docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg
        - docker-php-ext-install gd opcache zip

        - a2enmod headers rewrite
        - service apache2 stop
        - service apache2 start

        - echo memory_limit=1024M >> /usr/local/etc/php/conf.d/php.ini
        - echo upload_max_filesize=64M >> /usr/local/etc/php/conf.d/php.ini
        - echo post_max_size=64M >> /usr/local/etc/php/conf.d/php.ini

      update:
        - composer -d back-end install --optimize-autoloader

        - mkdir -p "${DOCROOT}/sites/default/files/"
        - chgrp www-data "${DOCROOT}/sites/default/files"

        - back-end/vendor/bin/drush deploy

      build:
        - composer -d back-end install --optimize-autoloader
        - back-end/vendor/bin/drush deploy

  nodejs:
    image: tugboatqa/node:24
    checkout: true
    expose: 3000
    depends: php

    commands:
      update:
        - npm ci --prefix front-end

      build:
        - echo "NEXT_PUBLIC_DRUPAL_BASE_URL=$TUGBOAT_DEFAULT_SERVICE_URL" > front-end/.env
        - npm run build --prefix front-end

        - mkdir -p /etc/service/node
        - echo "#!/bin/sh" > /etc/service/node/run
        - echo "npm run start --prefix ${TUGBOAT_ROOT}/front-end" >> /etc/service/node/run
        - chmod +x /etc/service/node/run

  mysql:
    image: tugboatqa/mariadb:10.11

    commands:
      init:
        - mysql -e "SET GLOBAL max_allowed_packet=536870912;"
        - echo "max_allowed_packet=536870912" >> /etc/mysql/conf.d/tugboat.cnf

      update:
        - mysqladmin -f drop tugboat
        - mysqladmin -f create tugboat
        - scp example.com/database.sql.gz /tmp/
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
```

## Next.js config

```js
const nextConfig = {
  ...
  experimental: {
    // Disable source maps on Tugboat.
    serverSourceMaps: !process.env.TUGBOAT_ROOT,
    // Limit CPU (and in turn, memory) usage on Tugboat.
    ...(process.env.TUGBOAT_ROOT && { cpus: 1 }),
  },
  // Disable ESLint and TypeScript on Tugboat.
  eslint: {
    ignoreDuringBuilds: !!process.env.TUGBOAT_ROOT,
  },
  typescript: {
    ignoreBuildErrors: !!process.env.TUGBOAT_ROOT,
  },
}

module.exports = nextConfig
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
