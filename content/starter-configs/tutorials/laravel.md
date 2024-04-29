---
title: "Laravel"
date: 2024-04-27T00:25:10Z
draft: true
weight: 5
---

Wondering how to configure Tugboat for a Laravel project? One of the claims of Laravel is "One Framework, Many Flavors",
so every Laravel project tends to have different requirements. You may need to do some customizing, but this should get
you started.

The following documentation assumes you are using Composer to manage your Laravel project, and that you are using
[Blade templates](https://laravel.com/docs/11.x/blade) styled with [Tailwind CSS](https://tailwindcss.com/); as frontend
tooling, your choice is [Vite](https://vitejs.dev/).

If you are using [Livewire](https://livewire.laravel.com/) or [Inertia](https://inertiajs.com/), or any other option, it
should be pretty similar.

## Configuring Laravel

A common practice for managing Laravel settings is to leave sensitive information, such as database credentials, in
environment variables. For development, you might have a an `.env.dev` or `.env.example` file on git.

This pattern works very well with Tugboat. It lets you keep a Tugboat-specific set of configurations in your repository,
where you can copy it into place with a
[configuration file command](/setting-up-services/how-to-set-up-services/leverage-service-commands/).

So let's create a `.tugboat/.env.tugboat` with your variables, and customize it for tugboat. You might want to base it
on your production values, or, less common, your dev environment values as a basis. The choice is yours. But for sure
you want to configure these values:

```dotenv
APP_URL=${TUGBOAT_DEFAULT_SERVICE_URL_HOST}

LOG_CHANNEL=stderr

DB_CONNECTION="mysql"
DB_HOST=database
DB_PORT=3306
DB_DATABASE=tugboat
DB_USERNAME=tugboat
DB_PASSWORD=tugboat

FILESYSTEM_DISK=local
QUEUE_CONNECTION=database

CACHE_STORE=database
CACHE_PREFIX=
```

- The `APP_URL` will use an environment variable for setting the url host.
- The `LOG_CHANNEL` will be the standard output, as this way we will see it more easily on the Tugboat UI or via the
  Tugboat CLI without needing to open a shell on it.
- The `DB_*` variables will depend on the database engine you pick on your `config.yml`, this assumes mysql.
- For files and queue system, you will use the local filesystem and database, but more complex options are also
  supported.
- You could also set your `APP_KEY` here with `${TUGBOAT_REPO_ID}`.

See [Enviroment variables](/reference/environment-variables) for more options on environment variables available.

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's a basic configuration you can use as a starting point, with comments
to explain what's going on:

```yaml
# Default Laravel 11 Tugboat starter config.
# https://docs.tugboatqa.com/starter-configs/tutorials/laravel/
services:
  # What to call the service hosting the site.
  webserver:
    # This uses PHP 8.3.x with Apache: update to match your version of PHP.
    image: tugboatqa/php:8.3-apache

    # Set this as the default service. This does a few things
    #   1. Clones the git repository into the service container
    #   2. Exposes port 80 to the Tugboat HTTP proxy
    #   3. Routes requests to the preview URL to this service
    default: true
    # Wait until the mysql service is done building.
    depends: database

    # A set of commands to run while building this service
    commands:
      # Commands that set up the basic preview infrastructure
      init:
        # Install opcache and mod-rewrite.
        - docker-php-ext-install opcache
        - a2enmod headers rewrite
        # Install node
        - apt-get update
        - apt-get install -yq ca-certificates curl gnupg
        - mkdir -p /etc/apt/keyrings
        - curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o
          /etc/apt/keyrings/nodesource.gpg
        - echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" |
          tee /etc/apt/sources.list.d/nodesource.list
        - apt-get update
        - apt-get install -yq nodejs
        # Copy the tugboat .env we created before
        - cp "${TUGBOAT_ROOT}/.tugboat/.env.tugboat" "${TUGBOAT_ROOT}/.env"
        # Link the document root to the expected path. This example links
        # /public to the docroot
        - ln -snf "${TUGBOAT_ROOT}/public" "${DOCROOT}"
        # Composer install
        - composer install --optimize-autoloader
        # Generate the random key if you didn't set APP_KEY before.
        - php artisan key:generate
        # Generate the db structure with some data. Here you have several choices:
        # 1. If you have seeders on your project, you might just run migrate with --seed.
        # - php artisan migrate --seed
        # 2. You might want just the structure without any test data.
        # - php artisan migrate
        # 3. Or you might load a database dump from somewhere else. That's up to you.
        - php artisan migrate --seed
        # Compile vite resources
        - npm install
        - npm run build
      update:
        # Include the APP URL in .env
        - echo "APP_URL=${TUGBOAT_DEFAULT_SERVICE_URL_HOST}" >> "${TUGBOAT_ROOT}/.env"
        - composer install --optimize-autoloader
        # Clear caches.
        - php artisan config:cache
        # Run any pending migrations. This will ensure your data has the last
        # migrations applied.
        - php artisan migrate --force
        # Ensure storage permissions
        - chgrp -R www-data "${TUGBOAT_ROOT}/storage"
        - find "${TUGBOAT_ROOT}/storage" -type d -exec chmod 2775 {} \;
        - find "${TUGBOAT_ROOT}/storage" -type f -exec chmod 0664 {} \;
        # Compile vite templates
        - npm install
        - npm run build
      build:
        # Include the APP URL in .env
        - echo "APP_URL=${TUGBOAT_DEFAULT_SERVICE_URL_HOST}" >> "${TUGBOAT_ROOT}/.env"
        - composer install --optimize-autoloader
        # Clear caches.
        - php artisan config:cache
        # Run any pending migrations. This will ensure your data has the last
        # migrations applied.
        - php artisan migrate --force
        # Compile vite templates
        - npm install
        - npm run build

  database:
    # Use the latest available version of MariaDB by not specifying a
    # version
    image: tugboatqa/mariadb:10.5
```

@TODO: Queue task runners.

Want to know more about something mentioned in the comments of this config file? Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Set the document root path](/setting-up-services/how-to-set-up-services/set-the-document-root-path/)
- [Set up remote SSH access](/setting-up-tugboat/select-repo-settings/#set-up-remote-ssh-access)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)
- [How Base Previews work](/building-a-preview/preview-deep-dive/how-previews-work/#how-base-previews-work)
- [Multisite with Tugboat](https://www.tugboatqa.com/blog/multisite-with-tugboat)

## Start Building Previews!

Once the Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
