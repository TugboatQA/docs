# Adding a phpMyAdmin Service

[phpMyAdmin](https://www.phpmyadmin.net/) is a user interface to connect to a
MySQL server. The [official Docker image](https://hub.docker.com/r/phpmyadmin/phpmyadmin)
can be used with Tugboat. Here is an example config.yml showing how you might
add a phpmyadmin service to your Tugboat project that has a MySQL 5.6 image.

```yaml
services:
  mysql:
    image: tugboatqa/mysql:5.6
  phpmyadmin:
    expose: 80
    image: phpmyadmin/phpmyadmin:4.8
    depends:
      - mysql
```

Once you've added the phpmyadmin service to your Tugboat config, you will need
to follow the instructions on the [Custom Environment Variables](../../advanced/custom-environment-variables/index.md)
to add the following environment variables to your Repository Settings:

- `PMA_HOST`: Set this to the name of the MySQL service that you would like phpmyadmin to connect to. In the example yml config above, the service name is `mysql`.
- `PMA_USER`: Set this environment variable to the MySQL user that can connect to the above MySQL service. Typically this is `tugboat`.
- `PMA_PASSWORD`: This is the password for the above user. Typically this value is `tugboat`.

Once you've added these custom environment variables, you're ready to build a
new Preview to test out phpMyAdmin. Note that we are exposing port 80 in the
config.yml above, which will give you a separate *Preview* button on the Tugboat
Preview Dashboard for phpMyAdmin:

![Click Preview to access phpMyAdmin](_images/preview.png)
