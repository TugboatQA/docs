# Pantheon/Drupal Makefile template for Tugboat

# Please modify the following environment variables to match your project.
# The Pantheon site name where the database and files will be copied from. If
# you're unsure, you can run 'terminus site:list --fields=id,name'.
PANTHEON_SOURCE_SITE ?= example-pantheon-site
# The Pantheon environment to pull the database and files from. This is
# typically dev, test, or live.
PANTHEON_SOURCE_ENVIRONMENT ?= live
# Specify the desired version of PHP in major.minor format, e.g. 7.1. For
# Pantheon sites, go to the dashboard of your site, click 'Settings', then click
# 'PHP Version'.
PHP_VERSION := 7.2
# Specify the Drupal site, which corellates to the name of the directory in
# your Drupal /sites directory. This is typically just default unless you are
# using Drupal multisite.
DRUPAL_SITE := default
# Specify the location of the directory that is the web root of the site,
# relative to the repo root, i.e. $TUGBOAT_ROOT. For example, if /web is where
# Drupal is installed, set DRUPAL_ROOT = ${TUGBOAT_ROOT}/web.
DRUPAL_ROOT := ${TUGBOAT_ROOT}
# This is the directory where you might keep configuration files that need to
# be distributed into your project for Tugboat, such as Drupal's settings.php
# or a .env specific to Tugboat.
DIST_DIR := ${TUGBOAT_ROOT}/.tugboat/dist
# This is the absolute path to public files directory. You should use the
# ${DRUPAL_SITE_DIR} variable here. For example, if your public files directory
# is sites/default/files, you would set this value to
# "${DRUPAL_SITE_DIR}/files".
DRUPAL_FILES_PUBLIC = ${DRUPAL_SITE_DIR}/files
# This is the absolute path to public files directory. You should use the
# ${DRUPAL_SITE_DIR} variable here. For example, if your public files directory
# is sites/default/files/private, you would set this value to
# "${DRUPAL_SITE_DIR}/files/private".
DRUPAL_FILES_PRIVATE = ${DRUPAL_SITE_DIR}/files/private

# Tugboat services have a handy Makefile in /usr/share/tugboat that we can use
# to simplify our setup process. We include that here. If you're curious what
# that gives you, you can run 'make -C /usr/share/tugboat' from any Tugboat
# service. Read more at https://docs.tugboat.qa/build-script/helper-makefile.
-include /usr/share/tugboat/Makefile

# Install our desired packages, including the PHP version we specified above,
# Composer, Terminus, and Drush. If you have other software that your project
# needs, add to this below.
packages: check-env install-php-$(PHP_VERSION) install-composer install-terminus install-drush
#	# Point the www dir that is served to the drupal root.
	ln -sf ${DRUPAL_ROOT} ${WWW_DIR}
#	# Authenticate to terminus. We prefix this with an @ symbol so that the
#	# token isn't printed to the logs.
	@terminus auth:login --machine-token=${PANTHEON_MACHINE_TOKEN}
#	# Run composer install on this repo.
	composer install --no-ansi

# Prepare everything for Drupal, including creating a settings.php, ensuring
# the files directory exists and is writeable, creates the drupal database, etc.
drupal-prep:
#	# Copy the settings.local.php that works for Tugboat into sites/default.
	cp ${DIST_DIR}/settings.local.php ${DRUPAL_SITE_DIR}/settings.local.php
#	# Generate a hash_salt to secure the site.
	echo "\$$settings['hash_salt'] = '$$(openssl rand -hex 32)';" >> ${DRUPAL_SITE_DIR}/settings.local.php
#	# Add a .tugboat.qa trusted host pattern to the settings file.
	echo "\$$settings['trusted_host_patterns'][] = '^.+\.tugboat\.qa$$';" >> ${DRUPAL_SITE_DIR}/settings.local.php
#	# Set up the default files directory, ensuring proper file permissions so
#	# that the www user can read and write.
	mkdir -p ${DRUPAL_FILES_PUBLIC} ${DRUPAL_FILES_PRIVATE}
	chgrp -R www-data ${DRUPAL_FILES_PUBLIC} ${DRUPAL_FILES_PRIVATE}
	chmod -R g+w ${DRUPAL_FILES_PUBLIC} ${DRUPAL_FILES_PRIVATE}
	chmod 2775 ${DRUPAL_FILES_PUBLIC} ${DRUPAL_FILES_PRIVATE}
#	# Now that we have a settings.php in place, create the database we need.
	$(DRUSH) sql-create

# Create a backup on Pantheon. We have a target for this because it's a
# necessary step for both importdb and importfiles.
create-backup: check-env
	terminus backup:create ${PANTHEON_SOURCE_SITE}.${PANTHEON_SOURCE_ENVIRONMENT}

# Import and sanitize a database backup from Pantheon.
importdb: check-env drupal-prep create-backup
	terminus backup:get \
		${PANTHEON_SOURCE_SITE}.${PANTHEON_SOURCE_ENVIRONMENT} \
		--to=/tmp/database.sql.gz \
		--element=db
#	# Clean out all existing tables.
	${DRUSH} sql-drop
#	# Import the new database dump.
	zcat /tmp/database.sql.gz | ${DRUSH} sql-cli
#	# Sanitize the new database dump.
	${DRUSH} sqlsan --sanitize-password=tugboat

# Import the files from Pantheon. You could also use Stage File Proxy module
# instead if you'd like to save disk space at the cost of page load performance.
importfiles: check-env drupal-prep create-backup
#	# Download the files from Pantheon using terminus.
	terminus backup:get \
		${PANTHEON_SOURCE_SITE}.${PANTHEON_SOURCE_ENVIRONMENT} \
		--to=/tmp/files.tar.gz \
		--element=files
#	# Untar the files to /tmp.
	tar -C /tmp -zxf /tmp/files.tar.gz
#	# Rsync them to the public files directory.
	rsync -av \
		--exclude=.htaccess \
		--delete \
		--no-owner \
		--no-group \
		--no-perms \
		/tmp/files_${PANTHEON_SOURCE_ENVIRONMENT}/ ${DRUPAL_FILES_PUBLIC}

# This is the target that defines how to build this project. Here you'd run any
# build steps that get run in production, such as running composer install,
# compiling SCSS, minifying JavaScript, running Drupal updates, clearing caches,
# importing Drupal configuration, etc.
#
# Rather than specifying each of these build steps here, it's recommended to
# create a script or command encapsulates all your build steps that all
# environments can use, including local, Dev, Test, Live, and Tugboat.
build:
	composer install --no-ansi
	${DRUSH} cr
	${DRUSH} updb

# This target ensures that we have all the environment variables we need to
# connect to Pantheon using terminus.
check-env:
	@if [ -z $(PANTHEON_SOURCE_SITE) ]; then\
		echo "You must set the PANTHEON_SOURCE_SITE variable in your Makefile." 1>&2;\
		exit 1;\
	fi;\
	if [ -z $(PANTHEON_SOURCE_ENVIRONMENT) ]; then\
		echo "You must set the PANTHEON_SOURCE_ENVIRONMENT variable in your Makefile." 1>&2;\
		exit 1;\
	fi;\
	if [ -z $(PANTHEON_MACHINE_TOKEN) ]; then\
		echo "You must set the PANTHEON_MACHINE_TOKEN variable in your Tugboat repository settings." 1>&2;\
		exit 1;\
	fi;\

# This target reduces disk space by cleaning up tmp directories and other non-
# essential files.
cleanup:
	apt-get clean
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Here are the actual targets that Tugboat calls. For more details on these
# targets, please see https://docs.tugboat.qa/build-script/#makefile. You'll
# notice they build on each other, i.e tugboat-init calls tugboat-update which
# calls tugboat-build.
tugboat-init: packages tugboat-update
tugboat-update: importdb importfiles tugboat-build
tugboat-build: build cleanup

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
