# Prebuilt Services

Tugboat maintains it's own registry of images. For details of any of these
images, see our
[GitHub Repository](https://github.com/Lullabot/tugboat-registry) for details.

> #### Hint:: I don't see a Service for X. Do you support it?
>
> We are adding new services all the time, feel free to
> [contact us](https://tugboat.qa/support) if there's something new you would
> like to see supported.
>
> For more advanced users it is possible to install any service you might
> require in the same container as your application this would require
> installing and configuring it yourself however. See
> [examples](../../examples/index.md) in the build script
> documentation.

We use Ubuntu for our base images, so all software is usually the latest
installable version found within Ubuntu package repository.

| Service Name       | Package Name(s)                                             |
| :----------------- | :---------------------------------------------------------- |
| apache             | apache2                                                     |
| apache-php         | apache2, libapache2-mod-php5                                |
| apache-php-drupal  | apache2, libapache2-mod-php5, composer, mysql-client, drush |
| apache-php7        | apache2, php7.0                                             |
| apache-php7-drupal | apache2, php7.0, composer, mysql-client, drush              |
| couchdb            | couchdb                                                     |
| elasticsearch-2.4  | elasticsearch-2.4                                           |
| elasticsearch-6    | elasticsearch-6                                             |
| mariadb            | mariadb-server                                              |
| memcached          | memcached                                                   |
| mongodb            | mongodb-org                                                 |
| mysql              | mysql-server                                                |
| mysql-56           | mysql-server-5.6                                            |
| nginx              | nginx                                                       |
| nginx-php          | nginx, php5-fpm                                             |
| nginx-php7         | nginx, php7.0                                               |
| nodejs             | nodejs-5.x                                                  |
| nodejs-5           | nodejs-5.x                                                  |
| nodejs-6           | nodejs-6.x                                                  |
| nodejs-8           | nodejs-8.x                                                  |
| postfix            | postfix                                                     |
| redis              | redis-server                                                |
| supervisord        | supervisor                                                  |
| ubuntu             | ubuntu-14.x (base image)                                    |

If we're not able to install a service you need, a
[self-hosted](https://tugboat.qa/enterprise) instance of Tugboat would give you
full control over the services available to Tugboat.
