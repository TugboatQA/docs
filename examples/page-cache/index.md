# Warm a Page Cache Within Tugboat

If your web application has a page caching layer, you can prime the cache from within the Tugboat config file.

```services:
  php:
    commands:
      build:
        # Warm the cache
        - "wget -e robots=off --quiet --page-requisites --delete-after --header \"Host: tugboat.qa\" http://localhost || /bin/true"
```

Calling `localhost` will cause Tugboat to load the front page of your application. `page-requisites` loads all images, and `delete-after` removes the downloaded assets to preserve disk space. 