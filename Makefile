GITBOOK_VERSION := 3.2.2

.PHONY: packages
packages:
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install --no-install-recommends -y nodejs
	npm install -g gitbook-cli

.PHONY: build
build:
	cd ${TUGBOAT_ROOT}/docs && \
		gitbook install --gitbook=$(GITBOOK_VERSION) && \
		gitbook build --gitbook=$(GITBOOK_VERSION)
	ln -sf ${TUGBOAT_ROOT}/docs/_book /var/www/html

.PHONY: cleanup
cleanup:
	apt-get clean
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

.PHONY: tugboat-init
tugboat-init: packages build cleanup

.PHONY: tugboat-build
tugboat-build: build cleanup
