# Tugboat services have a handy Makefile in /usr/share/tugboat that we can use
# to simplify our setup process. We include that here. If you're curious what
# that gives you, you can run 'make -C /usr/share/tugboat' from any Tugboat
# service.
-include /usr/share/tugboat/Makefile

docroot:
	ln -sf ${TUGBOAT_ROOT} /var/www/html

mysqlcreatedb:
	mysql -h mysql -u tugboat -ptugboat -e "create database mysite:"

mysqlimport:
	scp user@example.com:database.sql.gz /tmp/database.sql.gz
	zcat /tmp/database.sql.gz | mysql -h mysql -u tugboat -ptugboat mysite

cleanup:
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

tugboat-init: docroot install-package-mysql-client mysqlcreatedb mysqlimport cleanup
tugboat-update: mysqlimport cleanup
