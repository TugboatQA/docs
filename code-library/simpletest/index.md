# Automated Testing in Drupal with SimpleTest

Here is an example of how you might use Tugboat to run automated testing with
SimpleTest.

```services:
  php:
    commands:
      update:
        # Change permission of files directories
        - mkdir -p "${DOCROOT}/sites/default/files"
        - chgrp -R www-data "${DOCROOT}/sites"
        - find "${DOCROOT}/sites/default/files" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/sites/default/files" -type f -exec chmod 0664 {} \;

        # Create a simpletest directory
        - mkdir -p "${DOCROOT}/sites/simpletest"
        - chgrp www-data "${DOCROOT}/sites/simpletest"
        - chmod 2775 "${DOCROOT}/sites/simpletest"

      build:
        - SYMFONY_DEPRECATIONS_HELPER=weak SIMPLETEST_BASE_URL=http://localhost sudo -u www-data -E "${TUGBOAT_ROOT}/vendor/bin/phpunit" -c "${TUGBOAT_ROOT}/web/core/" --testsuite functional --group example
```
