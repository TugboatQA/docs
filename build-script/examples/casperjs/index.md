# Run CasperJS Tests

```
install:
    apt-get update
    apt-get install -y python phantomjs

test:
    casperjs test app.js

tugboat-init: install test
tugboat-update: test
tugboat-build: test
```
