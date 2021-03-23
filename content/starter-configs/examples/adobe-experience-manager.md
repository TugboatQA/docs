---
title: "Adobe Experience Manager"
date: Tue, Mar 23 2021
weight: 7
---

This AEM config example starts with a Tugboat Debian image, installs Java, and launches both the author and publisher
instances. You'll need to do some customizing for your app, but this should get you started.

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in your git repository. For the full config file, along with installation instructions, please see
the corresponding GitHub repository for
[configuring Adobe Experience Manager on Tugboat](https://github.com/TugboatQA/aem).

```yaml
services:
  author:
    image: tugboatqa/debian:10
    default: true
    expose: 4502

    commands:
      init:
        # Install Java SDK and Maven.
        - apt-get update && apt-get install -y openjdk-11-jdk maven

        # Create directory structure. license.properties is base64 encoded as a TB repos variable.
        - mkdir -p /opt/aem/author
        - echo "${LICENSE_PROPERTIES}" | base64 --decode > /opt/aem/author/license.properties
        - ln -snf ${TUGBOAT_ROOT} /opt/aem/code

        # Download AEM quickstart file and install
        - wget -O /opt/aem/author/aem-author-p4502.jar "${AEM_FILE_URL}"
        - cd /opt/aem/author && java -jar aem-author-p4502.jar -unpack

        # Configure Adobe public profile.
        - cp -r ${TUGBOAT_ROOT}/.tugboat/resources/.m2 ~/.m2
        - mvn help:effective-settings

        # Start aem for the first time and wait for a 200, authenticated response
        - CQ_PORT=4502 /opt/aem/author/crx-quickstart/bin/start
        - while [ "$(curl -u admin:admin --head --location --connect-timeout 5 -s -o /dev/null -w ''%{http_code}''
          localhost:4502)" != "200" ]; do sleep 5; done

      start:
        # Start aem a second time (faster)
        - CQ_PORT=4502 /opt/aem/author/crx-quickstart/bin/start
        - while [ "$(curl -u admin:admin --head --location --connect-timeout 5 -s -o /dev/null -w ''%{http_code}''
          localhost:4502)" != "200" ]; do sleep 5; done

        # Update the host of the default replication agent from localhost to the publish service.
        - curl -u admin:admin -F"sling:resourceType=cq/replication/components/agent"
          -F"transportUri=http://publish:4503/bin/receive?sling:authRequestLogin=1"
          http://localhost:4502/etc/replication/agents.author/publish/jcr:content

  publish:
    image: tugboatqa/debian:10
    default: false
    checkout: true
    expose: 4503

    commands:
      init:
        # Install Java SDK and Maven.
        - apt-get update && apt-get install -y openjdk-11-jdk

        # Create directory structure. license.properties is base64 encoded as a TB repos variable.
        - mkdir -p /opt/aem/publish
        - echo "${LICENSE_PROPERTIES}" | base64 --decode > /opt/aem/publish/license.properties
        - ln -snf ${TUGBOAT_ROOT} /opt/aem/code

        # Download AEM quickstart file and install
        - wget -O /opt/aem/publish/aem-publish-p4503.jar "${AEM_FILE_URL}"
        - cd /opt/aem/publish && java -jar aem-publish-p4503.jar -unpack

        # Start aem for the first time
        - CQ_PORT=4503 CQ_RUNMODE='publish' /opt/aem/publish/crx-quickstart/bin/start
        - while [ "$(curl --head --location --connect-timeout 5 -s -o /dev/null -w ''%{http_code}'' localhost:4503)" !=
          "200" ]; do sleep 5; done

      start:
        - CQ_PORT=4503 CQ_RUNMODE='publish' /opt/aem/publish/crx-quickstart/bin/start
        - while [ "$(curl --head --location --connect-timeout 5 -s -o /dev/null -w ''%{http_code}'' localhost:4503)" !=
          "200" ]; do sleep 5; done
```

Want to know more about something mentioned in the comments of this config file? Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
