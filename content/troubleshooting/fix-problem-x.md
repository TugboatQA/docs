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
- [My script is missing after a Preview build completes](#my-script-is-missing-after-a-preview-build-completes)
- [I'm not seeing GitHub repositories I expect to see](#missing-github-repositories)

## PHP out of memory issues

If you're getting "PHP out of memory errors", you can manually set the memory limit higher. If you're using one of the
[tugboatqa php images](/reference/tugboat-images/), use something like this in your build script:

`echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/my-php.ini`

If you would like unlimited memory allocated to PHP command-line scripts, you can add the following PHP snippet to your
application:

```php
if (PHP_SAPI === 'cli') {
  ini_set('memory_limit', '-1');
}
```

Or when executing PHP directly:

`php -d memory_limit=-1 path/to/php-script.php`

## MySQL server has gone away

If you're getting a "MySQL server has gone away" error, you can often resolve this by increasing the packet size for
MySQL.

To increase the `max_allowed_packet` to `512MB` you can add the following command to your MySQL service in the Tugboat
config.

`mysql -e "SET GLOBAL max_allowed_packet=536870912;"`

If you want this setting to persist after the build process, you can also add that setting to a MySQL cnf file that is
added to the [`init`](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained) command
group of your MySQL service.

`echo "max_allowed_packet=536870912" >> /etc/mysql/conf.d/tugboat.cnf`

Here is an example Tugboat config implementing the above techniques.

```yaml
services:
  mysql:
    ...
    commands:
      init:
        # Increase the allowed packet size to 512MB.
        - mysql -e "SET GLOBAL max_allowed_packet=536870912;"
        # Ensure this packet size persists even if MySQL restarts.
        - echo "max_allowed_packet=536870912" >> /etc/mysql/conf.d/tugboat.cnf
```

## cd isn't working

Each [command](/setting-up-services/how-to-set-up-services/leverage-service-commands/) is run in its own context,
meaning things like `cd` do not "stick" between commands. If that behavior is required, include an external script in
the git repository and call it from the config file.

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

This error occurs when a command in your config file can't be executed, or returns an error. When a Preview build fails
with this error:

1. [Check the Preview logs](../debug-config-file/#how-to-check-the-preview-logs) to see what command was running when
   the build failed.
2. If you don't spot an issue with the command,
   [terminal into the relevant Service](../debug-config-file/#debug-by-terminal-in-tugboat-s-web-ui) and try executing
   the command directly to get more context about what's happening.

If you're having trouble pinpointing the error, you may need to go back and execute your config file commands
line-by-line until you find the point at which things stop working.

{{% notice tip %}} A few common problems in config files include:
[`cd` does not "stick" between commands](#cd-isn-t-working) and
[running a background process "breaks" the build](#running-a-background-process). Check out the troubleshooting docs for
info on addressing these issues. {{% /notice %}}

If you've gone through the debugging process and haven't been able to figure out why your command is failing, reach out
to us at [help and support](/support/) - we're happy to take a look!

### 1074: Repo configuration does not allow building of pull requests from forks

If you're getting this error message, it's because you haven't enabled the
[repository setting](/setting-up-tugboat/select-repo-settings/) to allow building pull requests from forks.

This setting is off by default, but when it's enabled, Tugboat builds Previews for pull requests made to the primary
repo from forked repositories. Turning on this setting should correct this error.

{{% notice warning %}} When you enable this option in a public repository, anyone who can submit a pull request from the
fork can extract configured repository environment variables, as well as the private SSH key generated for the repo. The
latter is mainly a problem when the repository SSH key is added to some other service, like to pull a database or
checkout a related git repo. However, as an example, if the repository SSH key is allowed to _push_ changes to a git
repo, a malicious user would then have access to _modify_ that repo. {{% /notice %}}

## Running a background process

If you try to add a background-process to your [config file](/setting-up-tugboat/create-a-tugboat-config-file/) in the
conventional way, Tugboat will think the Preview has not finished building, and it will be stuck in the "building" state
until it eventually times out and fails.

For instructions on how to run a background within a Tugboat Preview, see:
[Setting up Services -> Running a Background Process](/setting-up-services/how-to-set-up-services/running-a-background-process/).

## My script is missing after a Preview build completes

If you've created a script that "sleeps" in the background while a Preview is being built, but that script is missing
when the Preview build completes, that's an expected behavior. When a Preview build completes, Tugboat stops the
containers to take [the build snapshot](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-snapshot).
After the data is committed, Tugboat restarts the containers to serve the Preview. Any scripts that were waiting for the
build to complete will no longer be present when the container is restarted.

To create a one-time script that runs after the Preview build completes, take a look at
[`runit`'s documentation](http://smarden.org/runit/runsv.8.html) - particularly the parts about creating a `finish`
script.

## Missing GitHub Repositories

Some Tugboat users have run into a case where they expect to see GitHub repositories in Tugboat, but those repositories
appear to be missing. There are a couple of ways this condition could manifest, and the fix for it depends on why the
GitHub repositories aren't visible.

### Tugboat had previously been authorized, but isn't anymore

If Tugboat has previously been authorized, but that authorization is revoked or expires, you'll no longer see an
organization's repositories in Tugboat's "Create a Repo" form. Our support team was able to take these steps to
reproduce the issue:

1. Tugboat is already authorized to GitHub.
2. Create a new GitHub org.
3. Create a new repo in that org.

Expected Behavior is that the new repository would show up in the list of available repos in Tugboat's "Create a Repo"
form. However, the authorizing org must take extra steps on the GitHub side to restore the repositories. This state can
occur if someone at the authorizing org mistakenly revokes Tugboat's authorization, but it also appears to be a known
issue for some products that use GitHub OAuth in integrations.

Short-term, the workaround for this issue is:

1. Go into [GitHub's Settings -> Applications](https://github.com/settings/applications);
2. Click into _Tugboat_ in the list of _Authorized OAuth Apps_, and authorize it for the missing organizations.

Now, the organizations and their repositories should appear in the Tugboat UI.

If this still doesn't fix the issue, some users have had success with revoking and re-connecting GitHub to Tugboat.

### Authorizing organization can't or won't grant org-level authorization

A different condition can cause a similar result; when you go to Tugboat's "Create a Repo" form, if you don't see a
repository you expect to see, it may be because an organization can't or won't grant organization-level OAuth
authorization. If you need to use an alternative method to authenticate with a git provider, see:
[Connect with Your Provider -> Authenticating using an API access token](/setting-up-tugboat/connect-with-your-provider/#authenticating-using-an-api-access-token).
