# Drupal 7 Makefile template for Tugboat.

# Please modify the following environment variables to match your project.
# Specify the desired version of PHP in major.minor format, e.g. 7.1.
PHP_VERSION := 7.1
# Specify the Drupal site, which corellates to the name of the directory in
# your Drupal /sites directory. This is typically just default unless you are
# using Drupal multisite.
DRUPAL_SITE := default
# Specify the location of the directory that is the web root of the site,
# relative to the repo root, i.e. $TUGBOAT_ROOT. For example, if /web is where
# Drupal is installed, set DRUPAL_ROOT = ${TUGBOAT_ROOT}/web.
DRUPAL_ROOT = ${TUGBOAT_ROOT}/web

# Tugboat services have a handy Makefile in /usr/share/tugboat that we can use
# to simplify our setup process. We include that here. If you're curious what
# that gives you, you can run 'make -C /usr/share/tugboat' from any Tugboat
# service.
-include /usr/share/tugboat/Makefile

packages: install-php-$(PHP_VERSION) install-package-mysql-client install-package-rsync install-drush
#	# Point /var/www/html to the drupal root. If Drupal 7 is installed in a
#	# docroot directory relative to your repo root, this is unnecessary.
	ln -sf ${DRUPAL_ROOT} ${WWW_DIR}

drupalconfig:
	cp $(DRUPAL_SITE_DIR)/tugboat.settings.php $(DRUPAL_SITE_DIR)/settings.local.php

createdb:
	$(DRUSH) create-db

importdb:
	scp user@example.com:database.sql.gz /tmp/database.sql.gz
	zcat /tmp/database.sql.gz | $(DRUSH) sql-cli

importfiles:
	rsync -av --delete user@example.com:/path/to/drupal/sites/default/files/ $(DRUPAL_SITE_DIR)/files/
	chgrp -R www-data $(DRUPAL_SITE_DIR)/files
	find $(DRUPAL_SITE_DIR)/files -type d -exec chmod 2775 {} \;
	find $(DRUPAL_SITE_DIR)/files -type f -exec chmod 0664 {} \;

stagefileproxy:
	$(DRUSH) pm-download stage_file_proxy
	$(DRUSH) pm-enable stage_file_proxy
	$(DRUSH) variable-set stage_file_proxy_origin "http://www.example.com"

build:
	$(DRUSH) cache-clear all

cleanup:
	apt-get clean
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## If syncing files directly into a Tugboat Preview
tugboat-init: packages drupalconfig createdb importdb importfiles build cleanup
tugboat-update: importdb importfiles build cleanup
tugboat-build: build

## If using Stage File Proxy to serve files
#tugboat-init: packages createdb drupalconfig importdb stagefileproxy build cleanup
#tugboat-update: importdb stagefileproxy build cleanup
#tugboat-build: build

#########
# There is often no need to modify anything below here.
DRUSH := drush -y --root=${DRUPAL_ROOT} --uri=${TUGBOAT_URL}
# The directory that the web server serves the site from. On Apache services
# this is /var/www/html. On Nginx services, it is /usr/share/nginx/html.
ifneq (,$(findstring nginx, $(TUGBOAT_SERVICE)))
  WWW_DIR := /usr/share/nginx/html
else
  WWW_DIR := /var/www/html
endif
# The path to the Drupal site dir.
DRUPAL_SITE_DIR := ${DRUPAL_ROOT}/sites/${DRUPAL_SITE}
