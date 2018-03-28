docroot:
	ln -sf ${TUGBOAT_ROOT} /var/www/html

mysqlclient:
	apt-get update
	apt-get install -y mysql-client

mysqlcreatedb:
	mysql -h mysql -u tugboat -ptugboat -e "create database mysite:"

mysqlimport:
	scp user@example.com:database.sql.gz /tmp/database.sql.gz
	zcat /tmp/database.sql.gz | mysql -h mysql -u tugboat -ptugboat mysite

cleanup:
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

tugboat-init: docroot mysqlclient mysqlcreatedb mysqlimport cleanup
tugboat-update: mysqlimport cleanup
