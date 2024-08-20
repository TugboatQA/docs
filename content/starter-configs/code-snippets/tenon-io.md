---
title: "Tenon.io Integration"
date: 2019-09-19T11:00:49-04:00
weight: 1
---

[Tenon.io](https://tenon.io) can identify 508 and WCAG 2.0 issues in any environment.

Before you use this snippet in you own [Tugboat config file](/setting-up-tugboat/create-a-tugboat-config-file/),
register for an account on Tenon.io and add your Tenon API Key to Tugboat as a
[custom environment variable](/setting-up-services/how-to-set-up-services/custom-environment-variables/) called
`TENON_API`.

```yaml
services:
  php:
    image: tugboatqa/php:8.1-apache

    commands:
      init:
        - apt-get update
        - apt-get install -y jq

      online:
        # Tenon Integration
        - touch results.json
        - curl -d "url=${TUGBOAT_SERVICE_URL}&key=${TENON_API}" -H Content-Type:application/x-www-form-urlencoded -H
          Cache-Control:no-cache -X POST https://tenon.io/api/ > results.json
        - "jq '{Summary: [.resultSummary .tests], title: .resultSet[] .errorTitle, description: .resultSet[]
          .errorDescription, snippet: .resultSet[] .errorSnippet, ref: .resultSet[] .ref, resultTitle: .resultSet[]
          .resultTitle, xpath: .resultSet[] .xpath}' results.json"
```
