# Prebuilt Services

Tugboat maintains it's own registry of images. For details of any of these images, see our [GitHub Repository](https://github.com/Lullabot/tugboat-registry) for details. 

We use Ubuntu for our base images, so all software is usually the latest installable version found with Ubuntu package repository.


| Service Name      | Package Name(s)                                             | Deprecated  |
| :------------     |:--------------                                              | :------:    |
| apache            | apache2                                                     |             |
| apache-php        | apache2, libapache2-mod-php5                                |             |
| apache-php-drupal | apache2, libapache2-mod-php5, composer, mysql-client, drush |             |
| apache-php7       | apache2, php7.0                                             |             |
| apache-php7-drupal| apache2, php7.0, composer, mysql-client, drush              |             |
| couchdb           | couchdb                                                     |             |
| elasticsearch-2.4 | elasticsearch-2.4                                           |             |
| elasticsearch-6   | elasticsearch-6                                             |             |
| mariadb           | mariadb-server                                              |             |
| memcached         | memcached                                                   |             |
| mongodb           | mongodb-org                                                 |             |
| mysql             | mysql-server                                                |             |
| mysql-56          | mysql-server-5.6                                            |             |
| nginx             | nginx                                                       |             |
| nginx-php         | nginx, php5-fpm                                             |             |
| nginx-php7        | nginx, php7.0                                               |             |
| nodejs            | nodejs-5.x                                                  |             |
| nodejs-5          | nodejs-5.x                                                  |             |
| nodejs-6          | nodejs-6.x                                                  |             |
| nodejs-8          | nodejs-8.x                                                  |             |
| postfix           | postfix                                                     |             |
| redis             | redis-server                                                |             |
| supervisord       | supervisor                                                  |             |
| ubuntu            | ubuntu-14.x (base image)                                    |             |

Don't see a service here you need? Reach out to us and see if we can add it for you. If it's not a volume-based image, we'll look into it and let you know if the service is a good candidate for Tugboat. If it's not a good match for the consumer version of Tugboat, a [self-hosted](https://tugboat.qa/enterprise) instance of Tugboat will allow you to run any image you need. 
