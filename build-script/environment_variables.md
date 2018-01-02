# Environment Variables

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

## Plugin Specific Variables
These variables are available when the corresponding plugins are installed.

Supported plugins:
- GITHUB
- BITBUCKET

### Variables

- **`$TUGBOAT_[plugin]_TITLE`**
   The title of the pull request.  For example,`$TUGBOAT_GITHUB_TITLE`

- **`$TUGBOAT_[plugin]_BASE`**
   The name of the base branch. For example,`$TUGBOAT_BITBUCKET_BASE`

- **`$TUGBOAT_[plugin]_HEAD`**
   The name of the head branch. For example,`$TUGBOAT_GITHUB_HEAD`

### Additional GitHub Variables

- **`$TUGBOAT_GITHUB_TOKEN`**
   The token used to authenticate to Github.

- **`$TUGBOAT_GITHUB_OWNER`**
   The owner of the GitHub repository.

- **`$TUGBOAT_GITHUB_REPO`**
   The name of the GitHub repository.

### Additional BitBucket Variables

- **`$TUGBOAT_BITBUCKET_OWNER`**
   The owner of the Bitbucket repository.

- **`$TUGBOAT_BITBUCKET_SLUG`**
   The URL-friendly name of the Bitbucket repository. See https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

## Notes
Tugboat previews are not built with an interactive bash session. This means that your .bashrc or any included files, such as .bash_aliases, are not loaded. This also means that global environment variables cannot be set inside any scripts that are run during the build. The only environment variables you will have global access to are those set explicitly by Tugboat.
