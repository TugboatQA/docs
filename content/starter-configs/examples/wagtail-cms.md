---
title: "Wagtail CMS"
date: Fri, Apr 16 2021
weight: 7
---

[Wagtail](https://wagtail.io/) is an open source CMS built in Python.

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in your git repository. For the full config file, along with installation instructions, please see
the corresponding GitHub repository for [configuring Wagtail on Tugboat](https://github.com/TugboatQA/wagtail).

```yaml
services:
  # Set the hostname
  python:
    image: tugboatqa/debian
    # In case multiple services are installed.
    default: true
    commands:
      init:
        - apt-get update && apt-get install python3 python3-pip python3-venv
        - python3 -m venv mysite/env
        - . mysite/env/bin/activate
        - pip3 install wagtail
        - wagtail start mysite mysite
        - cd mysite && pip3 install -r requirements.txt
        - cd mysite && python3 manage.py migrate
        # Create the admin user. The password could also be
        # stored as a Tugboat environment variable.
        - cd mysite && echo "from django.contrib.auth import get_user_model; User = get_user_model();
          User.objects.create_superuser('admin', 'root@localhost', 'tugboat')" | python3 manage.py shell
        # Cleanup to reduce disk space
        - apt-get clean
        - rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

      start:
        # Run on the default Tugboat port.
        - cd mysite && python3 manage.py runserver 0.0.0.0:80 &
# Optionally install a redis cache.
#  redis:
#    image: tugboatqa/redis

# Optionally install Elasticsearch.
#  elasticsearch:
#    image: tugboatqa/elasticsearch
```

Note that this config builds a Wagtail site from scratch. You'll likely want to deploy Tugboat into an existing site, so
additional steps will be needed to import your database and file assets into the build. One way you can do this by
importing the Tugboat Repository’s [SSH key](/setting-up-tugboat/select-repo-settings/#set-up-remote-ssh-access) to the
server hosting your site's data and then using `scp` for import. Here's an
[example](/starter-configs/code-snippets/import-mysql-database/) with mysql.

Want to know more about something mentioned in the comments of this config file? Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
