# Tugboat services have a handy Makefile in /usr/share/tugboat that we can use
# to simplify our setup process. We include that here. If you're curious what
# that gives you, you can run 'make -C /usr/share/tugboat' from any Tugboat
# service or view the source here:
# https://github.com/Lullabot/tugboat-registry/blob/master/baseimage/Makefile
-include /usr/share/tugboat/Makefile

# Build a preview from scratch. You can use install-package-% to install a
# package. For example, target tugboat-init will install wget first.
tugboat-init: install-package-wget
#	# You can also install packages inside of a target. For example, to install
#	# rsync, you would run:
	$(MAKE) install-package-rsync

tugboat-init:
#	# If you decide not to use the include statement, you can also use the
#	# helper Makefile without it like this:
	$(MAKE) -C /usr/share/tugboat install-package-rsync
