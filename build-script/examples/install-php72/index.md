# Install PHP 7.2

Using the helper tugboat Makefile makes upgrading to a specific version of PHP
easy. Just use the `install-php-%` target. For example, to install PHP 7.2:

```
-include /usr/share/tugboat/Makefile

tugboat-init: install-php-7.2
```
