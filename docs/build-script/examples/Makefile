# Tugboat services have a handy Makefile in /usr/share/tugboat that we can use
# to simplify our setup process. We include that here. If you're curious what
# that gives you, you can run 'make -C /usr/share/tugboat' from any Tugboat
# service or view the source here:
# https://github.com/Lullabot/tugboat-registry/blob/master/baseimage/Makefile
-include /usr/share/tugboat/Makefile

# Build a preview from scratch. You can use install-package-% to install a
# package. For example, tugboat-init will install wget first.
tugboat-init: install-package-wget
#	# You can also install packages inside of a target. For example, to install
#	# rsync, you would run:
	$(MAKE) install-package-rsync
#	# It's typically a good idea to call tugboat-update at the end of your init.
	$(MAKE) tugboat-update

# Update an existing preview
tugboat-update:
#	# pull in fresh data, if applicable
#	# It's typically a good idea to call tugboat-build at the end of the update.
	$(MAKE) tugboat-build

# Start from a base preview
tugboat-build:
	# run application-specific script(s)
	# compile, uglify, etc.
