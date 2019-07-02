# Tenon.io Integration

[Tenon.io](https://tenon.io) can identify 508 and WCAG 2.0 issues in any
environment.

To use this snippet in you own config file, register for an account on Tenon.io
and add your Tenon API Key to Tugboat as a
[custom environment variable](../../advanced/custom-environment-variables/index.md)
called `TENON_API`.

```yaml
services:
  php:
    image: tugboatqa/php:7-apache

    commands:
      init:
        - apt-get update
        - apt-get install -y jq

      build:
        # Tenon Integration
        - touch results.json
        - curl -d "url=${TUGBOAT_PREVIEW_URL}&key=${TENON_API}" -H
          Content-Type:application/x-www-form-urlencoded -H
          Cache-Control:no-cache -X POST https://tenon.io/api/ > results.json
        - "jq '{Summary: [.resultSummary .tests], title: .resultSet[]
          .errorTitle, description: .resultSet[] .errorDescription, snippet:
          .resultSet[] .errorSnippet, ref: .resultSet[] .ref, resultTitle:
          .resultSet[] .resultTitle, xpath: .resultSet[] .xpath}' results.json"
```
