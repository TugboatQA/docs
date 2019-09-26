---
title: "How to Fix Problem X"
date: 2019-09-19T12:39:25-04:00
weight: 4
---

- [PHP out of memory issues](#php-out-of-memory-issues)
- [MySQL server has gone away](#mysql-server-has-gone-away)
- [cd isn't working](#cd-isn-t-working)
- [Tugboat error messages](#tugboat-error-messages)
- [Running a background process "breaks" the build](#running-a-background-process)

## PHP out of memory issues

If you're getting "PHP out of memory errors", you can manually set the memory
limit higher. If you're using one of the
[tugboatqa php images](/reference/tugboat-images/), use something like this in
your build script:

`echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/my-php.ini`

Or you might try something like this in your drupal settings.php:

`if (drupal_is_cli()) { ini_set('memory_limit', '-1');`

## MySQL server has gone away

If you're getting a "MySQL server has gone away" error, you can resolve this by
increasing the packet size for MySQL.

To increase the max_allowed_packet to 512MB during the build stages, add this
before the mysql commands in the build script:

`mysql -e "SET GLOBAL max_allowed_packet=536870912;"`

If you want to do that, and make it "stick" during normal operation, use:

```
mysql -e "SET GLOBAL max_allowed_packet=536870912;"
echo "max_allowed_packet=536870912" >> /etc/mysql/conf.d/tugboat.cnf
```

## cd isn't working

Each
[command](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
is run in its own context, meaning things like `cd` do not "stick" between
commands. If that behavior is required, include an external script in the git
repository and call it from the config file.

1. Add your build steps to a file; for example: `.tugboat/init.sh`

```
#!/bin/sh

cd somewhere
run-a-command
```

2. Call that script from `config.yml` for the build step:

```
commands
  init: .tugboat/init.sh
```

Or, as a part of the build step:

```
commands:
  init:
    - /some/command
    - .tugboat/init.sh
    - /some/other/command
```

## Tugboat error messages

- [1064: Command Failed](#1064-command-failed)
- [1074: Repo configuration does not allow building of pull requests from forks](#1074-repo-configuration-does-not-allow-building-of-pull-requests-from-forks)

### 1064: Command Failed

This error occurs when a command in your config file can't be executed, or
returns an error. When a Preview build fails with this error:

1. [Check the Preview logs](../debug-config-file/#how-to-check-the-preview-logs)
   to see what command was running when the build failed.
2. If you don't spot an issue with the command,
   [terminal into the relevant Service](../debug-config-file/#debug-by-terminal-in-tugboat-s-web-ui)
   and try executing the command directly to get more context about what's
   happening.

If you're having trouble pinpointing the error, you may need to go back and
execute your config file commands line-by-line until you find the point at which
things stop working.

{{% notice tip %}} A few common problems in config files include:
[`cd` does not "stick" between commands](#cd-isn-t-working) and
[running a background process "breaks" the build](#running-a-background-process).
Check out the troubleshooting docs for info on addressing these issues.
{{% /notice %}}

If you've gone through the debugging process and haven't been able to figure out
why your command is failing, reach out to us at [help and support](/support/) -
we're happy to take a look!

### 1074: Repo configuration does not allow building of pull requests from forks

If you're getting this error message, it's because you haven't enabled the
[repository setting](/setting-up-tugboat/select-repo-settings/) to allow
building pull requests from forks.

This setting is off by default, but when it's enabled, Tugboat builds Previews
for pull requests made to the primary repo from forked repositories. Turning on
this setting should correct this error.

{{% notice warning %}} When you enable this option in a public repository,
anyone who can submit a pull request from the fork can extract configured
repository environment variables, as well as the private SSH key generated for
the repo. The latter is mainly a problem when the repository SSH key is added to
some other service, like to pull a database or checkout a related git repo.
However, as an example, if the repository SSH key is allowed to _push_ changes
to a git repo, a malicious user would then have access to _modify_ that repo.
{{% /notice %}}

## Running a background process

If you try to add a background-process to your
[config file](/setting-up-tugboat/create-a-tugboat-config-file/) in the
conventional way, Tugboat will think the Preview has not finished building, and
it will be stuck in the "building" state until it eventually times out and
fails.

For instructions on how to run a background within a Tugboat Preview, see:
[Setting up Services -> Running a Background Process](/setting-up-services/how-to-set-up-services/running-a-background-process/).
