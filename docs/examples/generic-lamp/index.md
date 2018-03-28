# Generic LAMP

A Generic LAMP stack should work with most PHP/MySQL web applications. Some
customizations may be required, but this should get you started.

## Services

In order to serve PHP pages, an apache webhead with PHP needs to be selected.
Some options include:

* apache-php (php-5.5.9)
* apache-php7 (php-7.0.26)

The PHP version provided by default in these containers can easily be
upgraded/downgraded as needed for your application. See [Install PHP
7.2](../build-script/install_php72.md) for an example of how to do that.

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

A build script for a database-backed application often consists of two parts

* Point Tugboat to the right document root
* Import a database

Start by creating a file named `Makefile` in the root of your repository. More
details about how this file works can be seen in our [Build
Script](../build-script/index.md) documentation, but we'll touch on the parts
you need to know here.

If there's one thing to remember about using a
[Makefile](https://www.gnu.org/software/make/), is that you **MUST** use tabs
for indents, not spaces.

### Configure a Document Root

By default, Tugboat tries to serve content from a `/docroot` folder in the root
of your git repository. If your repository is already set up like this, the
following step can be skipped.

To point Tugboat to the right location in your repository, add a line to the
`tugboat-init` section of the build script. To serve content from `/public_html`
in your repository add this.


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
accessible somewhere on the internet. There are a number of ways to do that, but
for this example we are going to assume that a recent mysqldump file is
available somewhere that can be accessed via SSH.

First, visit your [Repository
Settings](../tugboat-dashboard/repository/dashboard/index.md), and copy the
repository's public SSH key to the server hosting the mysqldump file. This
should typically go in a file at `~/.ssh/authorized_keys` in the home directory
of the user on the remote server that has access to the mysqldump file.

![Repository Public SSH Key](../_images/repo-public-key.png)

Then, add the following lines to the `tugboat-init` section of `/Makefile`

Make sure the MySQL client is installed

```sh
apt-get update
apt-get install -y mysql-client
```

Copy the mysqldump file from the remote server to the local /tmp directory

```sh
scp user@example.com:database.sql.gz /tmp/database.sql.gz
```

Create a database named `mysite` and import the mysqldump file into it

```sh
mysql -h mysql -u tugboat -ptugboat -e "create database mysite;"
zcat /tmp/database.sql.gz | mysql -h mysql -u tugboat -ptugboat mysite
```

Clean up to save space on your preview

```sh
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

### Full Makefile

[import, lang="makefile"](Makefile)
