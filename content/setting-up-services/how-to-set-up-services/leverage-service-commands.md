+++
title = "Leverage Service Commands"
date = 2019-09-19T13:03:56-04:00
weight = 3
+++

While technically optional, Service Commands are arguably the most powerful part of the
[configuration file](/setting-up-tugboat/create-a-tugboat-config-file/). This is the set of commands that Tugboat runs
in a Service container while creating a Preview.

The service commands are separated into a set of stages: `init`, `update`, and `build`. Each stage represents an
optional set of commands that Tugboat should run during that stage. For more info on the stages in the Preview build
process, check out:
[the build process: explained](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained).

It may help to think of the stages as groups of commands with a particular purpose. While not enforced in any way, the
stages roughly represent the following purposes:

- **init** - Run commands that set up the basic Preview infrastructure. This might include things like installing
  required packages or tools, or overriding default configuration files.

- **update** - Run commands that import data or other assets into a Service. This might include things like importing a
  database, or syncing image files into a service.

- **build** - Run commands that build or generate the actual site. This might include things like compiling Sass files,
  updating 3rd party libraries, or running database updates that the current code in the preview depends on.

{{% notice info %}} Each command is run in its own context, meaning things like `cd` do not "stick" between commands. If
that behavior is required, an external script should be included in the git repository and called from the config file.
{{% /notice %}}

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
    commands:
      init:
        - apt-get install nodejs
        - ln -snf "${TUGBOAT_ROOT}" "${DOCROOT}"
      update:
        - rsync -av example.com:files/ "${DOCROOT}/files/"
        - chgrp -R www-data "${DOCROOT}/files"
      build:
        - npm install
  mysql:
    image: tugboatqa/mysql:5.6
    commands:
      update:
        - scp example.com:mysqldump.sql.gz /tmp/
        - zcat /tmp/mysqldump.sql.gz | mysql tugboat
```

Notice that each stage is optional for a given service. There may not be any commands required for that service during
some stage. When that is the case, the stage can be excluded completely.
