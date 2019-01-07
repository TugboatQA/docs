# Adding a phpMyAdmin Service

Database management tools such as MySQL Workbench or Sequel Pro are commonly
used by developers to work with a MySQL database. However, Tugboat does not
provide a way for these tools to connect to a database for a Preview. A popular
alternative is to use [phpMyAdmin](https://www.phpmyadmin.net/) to fill this
gap.

> #### Warning::
>
> Exposing a phpMyAdmin service grants full access to the database for the
> Tugboat Preview to anyone that has the link. While it is best practice to
> avoid storing sensitive data in Tugboat, it is still a good idea to be careful
> about sharing this link.

The official phpMyAdmin
[Docker image](https://hub.docker.com/r/phpmyadmin/phpmyadmin) can be used with
Tugboat. Here is an example config.yml showing how you might add a phpmyadmin
service to a Tugboat Preview:

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
- **`PMA_USER`**: Set this environment variable to the MySQL user that can connect to the above MySQL service. Typically this is `tugboat`.
- **`PMA_PASSWORD`**: This is the password for the above user. Typically this value is `tugboat`.

Once you've added these environment variables, you're ready to build a new
Preview with phpMyAdmin. Note that we are exposing port 80 in the config.yml
above, which will give you a separate _Preview_ button on the Tugboat Preview
Dashboard for phpMyAdmin:

![Click Preview to access phpMyAdmin](_images/preview.png)
