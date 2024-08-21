# Adding Memcache

If you work on a hosting platform like Acquia you may want to also integrate Memcache into your tugboat setup.

In your tugboat config.yml.   Install the memcached library and pecl driver.  Also add a memcache container.
```
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

In your tugboat settings.php.  Reference the memcache container in the servers section and set to the defaults.
```
// Memcache on Tugboat
$settings['memcache']['servers'] = ['memcached:11211' => 'default'];
$settings['memcache']['bins'] = ['default' => 'default'];
$settings['memcache']['key_prefix'] = '';
$settings['cache']['default'] = 'cache.backend.memcache';
```

