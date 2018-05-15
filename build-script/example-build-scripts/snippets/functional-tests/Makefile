-include /usr/share/tugboat/Makefile

install: install-package-phantomjs

test:
	casperjs test app.js

tugboat-init: install test
tugboat-update: test
tugboat-build: test
