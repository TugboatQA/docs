packages:
	apt-get update
	apt-get install -y mysql-client rsync wget
	# Install drush-launcher. This assumes you are using composer to install
	# your desired version of Drush.
	wget -O /usr/local/bin/drush https://github.com/drush-ops/drush-launcher/releases/download/0.5.1/drush.phar
	chmod +x /usr/local/bin/drush
	composer install

drupalconfig:
	cp /var/www/html/sites/default/tugboat.settings.php /var/www/html/sites/default/settings.local.php
	echo "\$$settings['hash_salt'] = '$$(openssl rand -hex 32)';" >> /var/www/html/sites/default/settings.local.php

createdb:
	mysql -h mysql -u tugboat -ptugboat -e "create database demo;"

importdb:
	scp user@example.com:database.sql.gz /tmp/database.sql.gz
	zcat /tmp/database.sql.gz | mysql -h mysql -u tugboat -ptugboat demo

importfiles:
	rsync -av --delete user@example.com:/path/to/drupal/sites/default/files/ /var/www/html/sites/default/files/
	chgrp -R www-data /var/www/html/sites/default/files
	find /var/www/html/sites/default/files -type d -exec chmod 2775 {} \;
	find /var/www/html/sites/default/files -type f -exec chmod 0664 {} \;

stagefileproxy:
	drush -r /var/www/html pm-download stage_file_proxy
	drush -r /var/www/html pm-enable --yes stage_file_proxy
	drush -r /var/www/html variable-set stage_file_proxy_origin "http://www.example.com"

build:
	drush -r /var/www/html cache-rebuild

cleanup:
	apt-get clean
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## If syncing files directly into a Tugboat Preview
tugboat-init: packages createdb drupalconfig importdb importfiles build cleanup
tugboat-update: importdb importfiles build cleanup
tugboat-build: build

## If using Stage File Proxy to serve files
#tugboat-init: packages createdb drupalconfig importdb stagefileproxy build cleanup
#tugboat-update: importdb stagefileproxy build cleanup
#tugboat-build: build
