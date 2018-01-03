# Change the document root

By default, Tugboat tries to serve content out of a `/docroot` folder in the
root of a repository. If the web content is at a different path, such as
`/public_html`, use the build script to change where Tugboat looks.

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

