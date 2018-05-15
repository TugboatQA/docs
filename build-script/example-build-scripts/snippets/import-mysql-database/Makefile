-include /usr/share/tugboat/Makefile

tugboat-init: install-package-mysql-client
	scp dev.example.com/database.sql.gz /tmp/
	mysql -h mysql -u tugboat -ptugboat -e "create database tugboat;"
	zcat /tmp/database.sql.gz | mysql -h mysql -u tugboat -ptugboat tugboat
	rm /tmp/database.sql.gz
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
