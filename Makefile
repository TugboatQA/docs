.PHONY: packages
packages:
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install --no-install-recommends -y nodejs
	npm install -g gitbook-cli

.PHONY: build
build:
	cd ${TUGBOAT_ROOT}/docs && \
		gitbook install && \
		gitbook build
	ln -sf ${TUGBOAT_ROOT}/docs/_book /var/www/html

.PHONY: tugboat-init tugboat-build
tugboat-init: packages build
tugboat-build: build
