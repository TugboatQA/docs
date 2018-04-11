GITBOOK_VERSION := 3.2.3

-include /usr/share/tugboat/Makefile

.PHONY: packages
packages: install-nodejs-8
	npm install -g gitbook-cli
	npm install -g broken-link-checker-local

.PHONY: build
build:
	cd ${TUGBOAT_ROOT}/docs && \
		rm -rf node_modules && \
		gitbook install --gitbook=$(GITBOOK_VERSION) && \
		gitbook build --gitbook=$(GITBOOK_VERSION)
	blcl ${TUGBOAT_ROOT}/docs/_book
	ln -sf ${TUGBOAT_ROOT}/docs/_book /var/www/html

.PHONY: cleanup
cleanup:
	apt-get clean
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

.PHONY: tugboat-init
tugboat-init: packages build cleanup

.PHONY: tugboat-update
tugboat-update: build cleanup

.PHONY: tugboat-build
tugboat-build: build cleanup
