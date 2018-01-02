# Build Script

Tugboat provides a handful of hooks that allow customizations to how it acts at
various points during a preview's life cycle. It does this by providing a
number of environment variables, and by making calls to a build script.

The build script is a very powerful tool. It provides a framework to allow
developers to customize a stock Tugboat preview environment in order to make a
site work. For example, pulling a database, or installing an uncommon software
package, etc.

## Makefile
GNU Make is how Tugboat provides its hooks. The following targets can be added
to a file named `Makefile` in the root of a tugboat repository. If a `Makefile`
already exists, these can be added to it.

The target names have some legacy ties, and are still what they are for
backwards compatibility. This just means that their use is not exactly
intuitive.

* **tugboat-init** - This is called when a preview is built from scratch, after
  all of the services have been built, and the git repository has been cloned.
  This can be used for things like installing libraries or packages that are
  not present in the stock Tugboat containers, or modifying service
  configurations.

* **tugboat-build** - This is called when a preview is created from a base preview. The assumption is that things like a database or other assets are already present and just need to be updated. So, not all of the steps from _tugboat-init_ are required.

* **tugboat-build** - This is called during "tugboat build" after updating the local git repo. This can be used to perform any deployment scripts that might be required.

* **tugboat-update** - This is called when a preview is refreshed.
* **tugboat-update** - This is called during `tugboat update` after updating the local git repo. This can be used to downsync any data or other assets from a production/staging source.


Deployments *can* be done by using the Makefile natively, but chances are, you probably just want to call out to another script that does the heavy lifting.

The use of a Makefile, or any of the targets listed above is entirely **optional**.  Tugboat will gracefully skip over these steps if the Makefile, or one of the targets does not exist.

### Examples
## Tips

* Make sure you use tabs. Using spaces will cause errors.
* Check out [some examples](../examples/makefile.md) to get started.

## Environment Variables

Tugboat injects the following environment variables into every container, which you can use for various reasons.

**`$TUGBOAT_TAG`** - The tag used to identify the overall Tugboat environment.
For example, if the environment is for Pull Request 3258, this variable would be set to "pr3258".

**`$TUGBOAT_IMAGE`** - The image used to create the current container. For example, "apache" or "mysql".

**`$TUGBOAT_DOMAIN`** - The domain where the Tugboat environment is hosted. Unless otherwise configured, this value is the FQDN of the Tugboat host server.

For client projects this will be "projectname.tugboat.qa", or for local development this is "tugboat.local".

**`$TUGBOAT_TOKEN`** - The authentication token for the Tugboat environment.

This is used by the Tugboat HTTP proxy to grant access to an environment, and is passed through mostly as an informational value. Additional verification could be done in the application if necessary.

**`$TUGBOAT_URL`** - The URL for the Tugboat environment.
In addition to the environment variables above, the hostname of each container is set to

    ${TUGBOAT\_TAG}\_${TUGBOAT\_IMAGE}.${TUGBOAT\_DOMAIN}

For example, `latest_apache.projectname.tugboat.qa` or `pr4539_mysql.tugboat.local`.

### Plugin Specific Variables
These variables are available when the corresponding plugins are installed.

Supported plugins:
- GITHUB
- BITBUCKET

#### Variables

- **`$TUGBOAT_[plugin]_TITLE`**
   The title of the pull request.  For example,`$TUGBOAT_GITHUB_TITLE`

- **`$TUGBOAT_[plugin]_BASE`**
   The name of the base branch. For example,`$TUGBOAT_BITBUCKET_BASE`

- **`$TUGBOAT_[plugin]_HEAD`**
   The name of the head branch. For example,`$TUGBOAT_GITHUB_HEAD`

#### Additional GitHub Variables

- **`$TUGBOAT_GITHUB_TOKEN`**
   The token used to authenticate to Github.

- **`$TUGBOAT_GITHUB_OWNER`**
   The owner of the GitHub repository.

- **`$TUGBOAT_GITHUB_REPO`**
   The name of the GitHub repository.

#### Additional BitBucket Variables

- **`$TUGBOAT_BITBUCKET_OWNER`**
   The owner of the Bitbucket repository.

- **`$TUGBOAT_BITBUCKET_SLUG`**
   The URL-friendly name of the Bitbucket repository. See https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

### Notes
Tugboat previews are not built with an interactive bash session. This means that your .bashrc or any included files, such as .bash_aliases, are not loaded. This also means that global environment variables cannot be set inside any scripts that are run during the build. The only environment variables you will have global access to are those set explicitly by Tugboat.
