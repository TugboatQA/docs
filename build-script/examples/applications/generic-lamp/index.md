# Generic LAMP

A Generic LAMP stack should work with most PHP/MySQL web applications. Some
customizations may be required, but this should get you started.

## Services

To serve PHP pages, an Apache webhead with PHP needs to be selected. Some
options include:

* apache-php (php-5.5.9)
* apache-php7 (php-7.0.26)

The PHP version provided by default in these containers can easily be
upgraded/downgraded as needed for your application. See
[Install PHP 7.2](../../features/install-php72/index.md) for an example of how
to do that.

In addition, a MySQL or MariaDB database service needs to be selected.

![Generic LAMP: Services](_images/lamp-services.png)

The database server must be accessed with a network connection, and will always
be known by the service name you give it. In addition, a default user named
"tugboat" with a password of "tugboat" are available. So, for the above example,
connect to a database named "mysite" on the host "mysql" with a connection
string like the following:

```php
$mysqli = new mysqli('mysql', 'tugboat', 'tugboat', 'mysite');
```

or

```php
$connection = new PDO('mysql:dbname=mysite;host=mysql', 'tugboat', 'tugboat');
```

## Build Script

A [build script](../../../../build-script/index.md) for a database-backed
application often consists of two parts:

* Pointing Tugboat to the correct document root
* Importing a database

Start by creating a file named `Makefile` in the root of your repository. More
details about how this file works can be found in our
[Build Script](../../../../build-script/index.md) documentation, but we'll touch
on the parts you need to know here.

If there's one thing to remember about using a
[Makefile](https://www.gnu.org/software/make/), is that you **MUST** use tabs
for indents, not spaces.

### Configure a Document Root

By default, Tugboat tries to serve content from a `/docroot` folder in the root
of your git repository. If your repository is already set up like this, the
following step can be skipped.

To point Tugboat to the right location in your repository, add a line to the
`tugboat-init` section of the build script. To serve content from `/public_html`
in your repository add this:

```sh
tugboat-init:
    ln -sf ${TUGBOAT_ROOT}/public_html /var/www/html
```

Or, to serve directly from the root of your repository

```sh
tugboat-init:
    ln -sf ${TUGBOAT_ROOT} /var/www/html
```

### Import a Database

Before you can import a database into a Tugboat Preview, it needs to be
accessible somewhere on the Internet. There are several ways to do that, but for
this example we are going to assume that a recent `mysqldump` file is available
somewhere that can be accessed via SSH.

First, visit your
[Repository Settings](../../../../tugboat-dashboard/repositories/index.md), and
copy the repository's public SSH key to the server hosting the mysqldump file.
This should typically go in a file at `~/.ssh/authorized_keys` in the home
directory of the user on the remote server that has access to the `mysqldump`
file.

![Repository Public SSH Key](../_images/repo-public-key.png)

Make sure the MySQL client is installed. To do this, we can make use of the
[helper Makefile](../../../../build-script/helper-makefile/index.md) in
`/usr/share/tugboat`, so we're going to use that to install any packages we
need.

```sh
-include /usr/share/tugboat/Makefile

tugboat-init: install-package-mysql-client
```

Copy the `mysqldump` file from the remote server to the local /tmp directory

```sh
scp user@example.com:database.sql.gz /tmp/database.sql.gz
```

Create a database named `mysite` and import the `mysqldump` file into it

```sh
mysql -h mysql -u tugboat -ptugboat -e "create database mysite;"
zcat /tmp/database.sql.gz | mysql -h mysql -u tugboat -ptugboat mysite
```

Clean up to save space on your Preview

```sh
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

### Full Makefile

[import, lang="makefile"](Makefile)
