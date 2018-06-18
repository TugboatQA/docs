# Run Functional Tests

Here is an example of how you might use Tugboat to run functional tests. In this
case, the tests are run with CasperJS.

```yaml
services:
  apache:
    image: tugboatqa/node:8
    commands:
      init:
        - apt-get update
        - apt-get install -y phantomjs
        - casperjs test app.js
      build:
        - casperjs test app.js
      update:
        - casperjs test app.js
```
