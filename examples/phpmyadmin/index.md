# Adding a phpMyAdmin Service

[phpMyAdmin](https://www.phpmyadmin.net/) is a user interface to connect to a
MySQL server. The
[official phpMyAdmin Docker image](https://hub.docker.com/r/phpmyadmin/phpmyadmin)
can be used with Tugboat. Here is an example config.yml showing how you might
add a phpmyadmin service to a Tugboat Preview.

```yaml
services:
  mysql:
    image: tugboatqa/mysql:5
  phpmyadmin:
    expose: 80
    image: phpmyadmin/phpmyadmin
```

> #### Hint::MySQL 8
>
> MySQL 8 uses a new authentication method, which does not work with the PHP
> mysqli extension that phpMyAdmin uses. To work around this, alter the
> "tugboat" MySQL user with an init command for the `mysql` service.
>
> ```yaml
> mysql:
>   image: tugboatqa/mysql:8
>   commands:
>     init:
>       mysql -e "ALTER USER 'tugboat'@'%' IDENTIFIED WITH mysql_native_password
>       BY 'tugboat';"
> ```

Once you've added the phpmyadmin service to your Tugboat config, you will need
to follow the instructions on the
[Custom Environment Variables](../../advanced/custom-environment-variables/index.md)
to add the following environment variables to your Repository Settings:

- **`PMA_HOST`** - Set this to the name of the MySQL service that you would like
  phpmyadmin to connect to. In the example yml config above, the service name is
  `mysql`.

- **`PMA_USER`** - Set this environment variable to a username you would like to
  use to authenticate to phpMyAdmin.

- **`PMA_PASSWORD`** - Set this environment variable to the password for the
  above user.

Once you've added these environment variables, you're ready to build a new
Preview with phpMyAdmin. Note that we are exposing port 80 in the config.yml
above, which will give you a separate _Preview_ button on the Tugboat Preview
Dashboard for phpMyAdmin:

> #### Warning::
>
> The link to the phpMyAdmin services grants full access to the database for the
> preview. While it is best practice to avoid storing sensitive data in a
> Tugboat Preview, it is still a good idea to be careful about sharing this
> link.

![Click Preview to access phpMyAdmin](_images/preview.png)
