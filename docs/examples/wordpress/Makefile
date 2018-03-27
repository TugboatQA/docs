packages:
	apt-get update
	apt-get install -y mysql-client rsync
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

wpconfig:
	echo "<?php" > /var/www/html/wp-config.local.php
	echo "define('DB_NAME','demo');" >> /var/www/html/wp-config.local.php
	echo "define('DB_USER','tugboat');" >> /var/www/html/wp-config.local.php
	echo "define('DB_PASSWORD','tugboat');" >> /var/www/html/wp-config.local.php
	echo "define('DB_HOST','mysql');" >> /var/www/html/wp-config.local.php

createdb:
	mysql -h mysql -u tugboat -ptugboat -e "create database demo;"

importdb:
	scp user@example.com:database.sql.gz /tmp/database.sql.gz
	zcat /tmp/database.sql.gz | mysql -h mysql -u tugboat -ptugboat demo
	wp --allow-root --path=/var/www/html search-replace 'wordpress.local' "${TUGBOAT_PREVIEW}-${TUGBOAT_TOKEN}.${TUGBOAT_DOMAIN}" --skip-columns=guid

importuploads:
	mkdir -p /var/www/html/wp-content/uploads || /bin/true
	rsync -av --delete user@example.com:/path/to/wp-content/uploads/ /var/www/html/wp-content/uploads/
	chgrp -R www-data /var/www/html/wp-content/uploads
	find /var/www/html/wp-content/uploads -type d -exec chmod 2775 {} \;
	find /var/www/html/wp-content/uploads -type f -exec chmod 0664 {} \;

cleanup:
	apt-get clean
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

tugboat-init: packages wpconfig createdb importdb importuploads cleanup
tugboat-update: importdb importuploads cleanup
tugboat-build:
	wp --allow-root \
		--path=/var/www/html \
		search-replace "${TUGBOAT_BASE_PREVIEW}-${TUGBOAT_BASE_PREVIEW_TOKEN}.${TUGBOAT_DOMAIN}" \
		"${TUGBOAT_PREVIEW}-${TUGBOAT_TOKEN}.${TUGBOAT_DOMAIN}" \
		--skip-columns=guid
