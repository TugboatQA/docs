# Change the document root

Tugboat tries to serve content out of a `/docroot` folder in the root of a
repository. It does this by linking `${TUGBOAT_ROOT}/docroot` to the default
document root of the web server. If the repository's web content is at a
different path, such as `/public_html`, use the build script to change where
Tugboat looks.

## apache

```
tugboat-init:
    ln -sf ${TUGBOAT_ROOT}/public_html /var/www/html
```

## nginx

```
tugboat-init:
    ln -s ${TUGBOAT_ROOT}/public_html /usr/share/nginx/html
```

