# Changelog

## v2.18.05.09.0

* Remove broken upgrade script to detect repo admin access
* Fix wrong variable name in getPreviewConfig
* Fix CLI shell access to a preview ID
* Support running build scripts in each service container

## v2.18.05.03.0

* Split the repo auto-build config into three separate configs to automatically build, rebuild, or delete pull request previews
* Support webhooks from all four git providers
* Filter deprecated repo config fields in preparation for including them as service configs in .tugboat.yml
* Regenerate certificates for tugboat.local
* CLI support for visualdiff API endpoints
* Remove "tugboat" top key from .tugboat.yml spec
* Change the "webhead" yaml service flag to "default"
* CLI support for provider and plugin API endpoints
* Prevent users from selecting repos they do not have admin access to
* Remove unused repo config fields from UI, for simplification

## v2.18.04.26.0

* Prevent leaking provider authentication via git remotes & logged git commands
* Fix proptype warning in DisconnectedModal
* CLI support for provider-supplied API endpoints
* Upgrade services in-place when they are missing an image field
* Respect log filter for incoming log events
* Prevent previews from getting stuck in a "cloning" state

## v2.18.04.23.0

* Add the ability to clone a preview
* Use xterm.js to render preview logs
* Fall back to non-unicode characters for Windows CLI

## v2.18.04.19.0

* Add a dedicated URL for monitoring the Tugboat Proxy status
* Split tugboat server control from the CLI tool
* Fix broken URL in HTML version of the welcome email
* Better method of testing for the existence of a Makefile target
* Documentation to help decide how to structure Tugboat Projects

## v2.18.04.09.0

* Fix broken links in documentation

## v2.18.04.08.0

* Send welcome email to users when they create a new account
* Fix network allocation retry logic

## v2.18.04.07.0

* Updated Makefile documentation

## v2.18.04.06.0

* When shell size is specified, explicitly set TTY size
* Recalculate orphaned preview size when base preview is deleted
* Documentation: how to inject secret data with environment variables
* Use a non-dismissable modal to show when server connection is lost

## v2.18.04.05.0

* Support service configuration in .tugboat.yml for github, bitbucket, and gitlab
* Fix a server crash condition in agents.emitAll()
* Keep trying to find an available network if allocation fails
* Stop containers before committing, avoids a race condition where service processes don't have time to flush to disk before being suspended.
* Allow alternate authentication for commenting on provider pull/merge requests
* Start TuSH in application root
* Implement getYML() for the git provider
* Show the newer of build time vs refresh time
* Smooth scroll to top of page on create project form error
* Fix repo preview count accuracy
* Link to marketing enterprise page on UI tier selector

## v2.18.03.29.0

* Provide custom error pages from the internal apache service
* Clean up noisy agent logging from emitAll()

## v2.18.03.28.1

* Fix UI user.email database index

## v2.18.03.28.0

* Remove Tugboat's dedicated test suite runner in favor of recommending 3rd party tools like circleci or travis
* Change internal networking to bridged instead of overlay
* Actually fix bitbucket & gitlab authentication
* Make sure mongoose is connected before issuing queries
* Exclude built-in docker networks from preview network pool
* Store session data in mongo instead of on the socket object
* Fix Makefile whitespace in documentation examples

## v2.18.03.16.0

* Allow a system-wide configurable default provider
* Fix GitLab authentication
* Disable UI to change authorized provider accounts for a repo

## v2.18.03.13.0

* New API endpoints to query a repo's authenticated provider account
* Initial implementation of using a YML file for configuration
* Allow repo admins to authenticate a provider bot account
* Create a UI to change the authorized GitHub account for a repo
* Parse octokat errors into JS objects
* Fix win32 CLI binary
* Wrap linux & macos CLI binaries in a tarball to fix downloads
* Don't show screenshots for dummy previews

## v2.18.03.11.0

* Use a monospace font for the "ready command" input form
* Support Bitbucket app passwords for repo authentication
* Remove agent/server version check
* Allow tugboat admins to set a custom repo auth "owner"
* Add troubleshooting docs for spaces instead of tabs in Makefile
* Move user permission checks to a separate set of selectors
* Create a stub for a common internal provider API
* Sanitize key & repo data before emitting API events
* Fix WordPress branding (capital P)
* Fix CLI regressions
* Expand the use of jest unit tests
* Make build scripts handle spaces in paths

## v2.18.03.01.1

* Temporarily remove download link for win32 CLI

## v2.18.03.01.0

* Add CLI help text to all subcommands
* Fix "insecure" CLI config file option
* Link to provider in repo dashboard header opens a new tab/window
* Provide CLI tool download links in UI
* Move build alerts to the end of the build
* Update CLI codebase to use async/await instead of async.js
* Update Drupal 8 documentation
* Upgrade octokat to latest version
* Fix updating API keys

## v2.18.02.26.0

* Test coverage of the Access Token UI
* Allow the scheduler to spawn a mongodb backup container

## v2.18.02.22.0

* Provide an API Key Management UI
* Fix service size calculations

## v2.18.02.21.0

* Always trigger a reload of the splash screen when state is "ready"
* Add a section on Base Previews to the docs
* Clarify environment variable persistence in the docs
* Switch from gulp/browserify/bower to webpack
* Fact-check and link-check of FAQ
* Fix user dropdown styles
* Allow admins of a project access to view and update payment info

## v2.18.02.16.0

**Features**

* Sort service list alphabetically, but keep webhead at the top
* Google Analytics integration into dashboard
* READ notes for windows development
* Upgrade GitLab API calls to v4

**Bugs**

* Fix preview stats when changing projects
* Remove broken fallback "ready" check that looked for exposed ports
* Always pull after fetching a branch
* Fix mail capture

**Other**

* Finished cleaning up coding standards
* Additional debug logging
* Clearer language on Delete Project option

## v2.18.02.09.0

**Features**

* Improved provider authentication error handling
* More granular build/watch execution options

**Bugs**

* Track which user authorized a repo
* refresh auth tokens on UI login

**Other**

* Upgrade to NodeJS 8.x
* Fix apache config https://github.com/docker-library/httpd/commit/17166574dea6a8c574443fc3a06bdb5a8bc97743
* Improved Documentation
* Improved Test Coverage
* Improved Test Coverage
* Improved Test Coverage
* Improved Test Coverage
* Improved Test Coverage
* Improved Test Coverage

## v2.18.01.29.0

**Bugs**

* Added Tugboat branding to recurly templates

**Other**

* Documentation
* More UI unit tests

## v2.18.01.24.0

**Features**

* Provide information about a preview's base preview in environment variables

**Bugs**

* Fix a crash condition when changing repo services between biulds
* Fix a race condition when deleting a project or repo that has previews
* Fix a crash condition when serving error pages from the proxy

**Other**

* Additional UI unit tests
* Documentation

## v2.18.01.22.0

**Bugs**

* Prevent crashing when a new repo selects a null agent
* Prevent key hash from leaving API
* Fix broken visualdiff screenshots

**Features**

* Expose UI version via /_version URL
* Allow users to cancel a suspending preview

## v2.0.0-beta-20180119.00

**Bugs**

* Fix a problem with previews not loading on the repo dashboard
* Attempt to stabalize the agent proxy services

**Features**

* Add an indicator to previews that were built from a base preview
* Fix a problem with the first startup on a new tugboat installation

**Other**

* Move agent services to a single global swarm service
* Documentation
* Return an "unavailable" screen while UI is still starting up

## v2.0.0-beta-20180103.00

**Bugs**

* Fix missing webhead for "Generic LAMP" template

**Other**

* Documentation

## v2.0.0-beta-20171215.00

**Features**

* Add API key children feature to API
* Make the provider icon a link back to provider repo on the repo dashboard

**Bugs**

* Hide the preview size while building/rebuilding
* Fix a problem with the repo/project stats not refreshing
* Make provider icons clickable with the link they represent
* Fix 502 page styling in agent-proxy, clean up "reloading" state
* Fix preview/reset, use the right base image when resetting

**Other**

* Make the agent management script more flexible
* Move text output handlers from API to CLI
* Clearer copy about choosing a template
* Fix tugboatception link to staging cluster

## v2.0.0-beta-20171212.00

**Features**

* Improved email notifications
* New splash pages when previews are unabled to be viewed
* Reload splash page when preview is deleted

**Bugs**

* Fix some problems with recovering after Docker restarts

## v2.0.0-beta-20171208.00

**Features**

* Change the color of "Suspended" to a muted green
* Add tooltips to the UI for deeper explanation of certain elements
* Create templates for Recurly email notifications

**Bugs**

* Service states track preview states more closely
* Fix some React PropType errors
* Change the wording of the repository selector to not imply the ability to select multiple repositories
* Modify the run command for the mongo service, so it binds to the service IP address

**Other**

* Minimize the number of font variations used throughout Tugboat

## v2.0.0-beta-20171203.00

**Features**

* Pull latest image on preview create/rebuild/refresh
* Better subscription tier management
* Handle new .shtml splash pages
* Limit SSH key file upload to 10KB

**Bugs**

* Prevent multiple schedulers from spawning
* Prevent race condition, wait for a repo ssh key before building a preview

**Other**

* Coding Standards cleanups
* Improved Vagrant config

## v2.0.0-beta-20171121.00

**Features**

* Create a UI for the per-repo SSH Key management API
* Include more tugboat info in ENV variables
* More specific instructions in welcome CTA

**Bugs**

* Minor style fixes for visual diffs
* Fix repo dropdown positioning bug

## v2.0.0-beta-20171120.00

**Features**

* Style preview screenshots when there is no base preview
* Create an SSH keypair for every repo, add API endpoints for management
* Provide config options for preview data and mongo storage locations

**Bugs**

* Prevent race condition when setting services from a template. Clean up an errant object property that ended up creating an invalid repo config field.

**Other**

* Upgrade prettier and add a default config

## v2.0.0-beta-20171116.00

**Features**

* Add visual diffs and screenshots to preview dashboard
* Show a "pending downgrade" notification on tier selector
* Mobile style refresh
* Sort repository config fields into a logical order

**Bugs**

* Use the right GitLab group key
* Fix the onboarding repo-select form
* Fix missing repository breadcrumb
* Fix string wrapping of tier info for Firefox
* Fix breadcrumb overflow

**Other**

* End-user documentation

## v2.0.0-beta-20171113.00

**Features**

* Connect provider accounts from profile page
* Clarify "My Projects" navigation, be more consistent with redirects
* Show a Welcome CTA on the project dashboard
* Create a "Permission Denied" page
* Clean up styles for the base preview management modal
* Consistent use of breadcrumbs on all pages
* Allow auto-closed PRs to be re-auto-built if re-opened

**Bugs**

* Redirect to repo page when preview is deleted from its own page
* Restrict access to repo/add to project admins
* Fix UI updates when upgrading tier
* Allow the UI to set multiple base previews
* Sort tiers by price
* Fix the pull request auto-build system

**Other**

* Add some troubleshooting tips to README for local development

## v2.0.0-beta-20171108.00

**Features**

* Better styles for disabled form elements
* New welcome banner

**Bugs**

* Fix delay in closing alert bar notification
* Handle stdout/stderr log events
* Connect proxy to preview network when services start
* Use the default config type of "string" when it is not specified
* Fix agent start script on worker nodes
* Fix GitLab authentication
* Fix previews create/rebuild for Bitbucket PR previews
* Fix previews/create for GitLab PR previews
* Fix a react error with duplicate provider passports
* Fix previews/rebild for GitHub PR previews
* Fix GitHub previews/refresh
* Fix project/repo/preiew/service size calculations

**Other**

* More coding standards cleanups
* Remove unused tugboat_build_anchors_before hooks from provider plugins
* Verify desired functionality of preview create/rebuild/refresh for all providers

## v2.0.0-beta-20171101.00

**Features**

* Add a new previews/rebuild API call
* Show services used by the selected template
* Add validation for number fields

**Bugs**

* Fix web TuSH input handler and row/col calculations
* Fix a React error about number field proptype

**Other**

* Cleaned up unused internal events
* Improved API stability
* Better error messages on failures
* Overhaul config.js internal use
* Refreshed API test suite
* Split process management for server/agent

## v2.0.0-beta-20171030.00

**Features**

* Remove the status link from providers (where possible) when preview is deleted.
* Add a confirmation modal when deleting a project
* Provider links point to Dashboard instead of directly to the preview
* Add a confirmation modal when deleting a user from a project
* Use provider terminology where appropriate
* Remove "Demo" option from onboarding process
* Use local date format on pending project invites
* Add form validation to email invite
* Add form validation to generated repo config form
* Replacee dropdown with text if there is only one provider option
* Use "Select my own repository" by default in new project form

**Bugs**

* Prevent preview from suspending when there is an active TuSH session
* Delete comments when preview is deleted or rebuilt
* Subscribe to new repo when created with project
* Fix GitLab spelling (capital L)
* Fix an errant Bitbucket option in GitLab configs
* Fix styles on Project Name form validation
* Fix "Add a Repository" page on hard refresh
* Fix rounded corners on buttons in latest Chrome

**Performance**

* Delete repos in the background on projects/delete
* Delete previews in the background on repos/delete

**Other**

* More progress on Coding Standards cleanup
* Clean up wording on delete descriptions
* Import existing documentation as a starting point

## v2.x.x

This is a major rewrite of Tugboat. Some noteable new features include

* Multiple repositories per project
* Enforceable quotas per project/repo
* API key management
* More flexible preview architecture
* Multi-tenant architecture
* Clusterable infrastructure