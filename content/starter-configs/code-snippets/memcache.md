# Adding Memcached to Drupal Previews

If your Drupal site uses memcached in production, you may also want to add a memcached service to your Tugboat Previews.

In your Tugboat config.yml. Install the memcached library and pecl driver. Also add a memcached service.

```yaml
services:
  php:
    image: tugboatqa/php:8.3-apache
    commands:
      init:
        - apt-get update
        - apt-get install libzip-dev libmemcached-dev zlib1g-dev libssl-dev
        - echo yes '' | pecl install -f memcached-3.2.0
        - docker-php-ext-enable opcache zip memcached

  # Add a memcached container
  memcached:
    image: tugboatqa/memcached:latest
```

In your Tugboat Drupal `settings.php` add the reference to the memcache container with default options.

```php
// Memcache on Tugboat
$settings['memcache']['servers'] = ['memcached:11211' => 'default'];
$settings['memcache']['bins'] = ['default' => 'default'];
$settings['memcache']['key_prefix'] = '';
$settings['cache']['default'] = 'cache.backend.memcache';
```
