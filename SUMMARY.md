# Summary

- [Introduction](README.md)

* [Setting up your Tugboat](setting-up-tugboat/index.md)

  - [Connect with your provider](setting-up-tugboat/index.md#connect-with-your-provider)
  - [Create a new project](setting-up-tugboat/index.md#create-a-new-project)
  - [Add repos to the project](setting-up-tugboat/index.md#add-repos-to-the-project)
  - [Repository Settings (optional)](setting-up-tugboat/index.md#repository-settings-optional)
  - [Create a Tugboat config file](setting-up-tugboat/index.md#create-a-tugboat-config-file)

* [Administering Tugboat crew](administering-tugboat-crew/index.md)

  - [Add a user to a project](administering-tugboat-crew/index.md#add-a-user-to-a-project)
  - [Remove a user from a project](administering-tugboat-crew/index.md#remove-a-user-from-a-project)
  - [Change user permissions](administering-tugboat-crew/index.md#change-user-permissions)
  - [Add a Tugboat bot to your team](administering-tugboat-crew/index.md#add-a-tugboat-bot-to-your-team)
  - [User permission levels explained](administering-tugboat-crew/index.md#user-permission-levels-explained)

* [Building a Preview](building-a-preview/index.md)

  - [Build a Preview](building-a-preview/index.md#build-a-preview)
  - [Share your Preview](building-a-preview/index.md#share-your-preview)
  - [Preview Actions](building-a-preview/index.md#preview-actions)
  - [Preview status](building-a-preview/index.md#preview-status)
  - [Set a Base Preview](building-a-preview/index.md#set-a-base-preview)
  - [Administer Base Previews](building-a-preview/index.md#administer-base-previews)
  - [Auto-generate Previews](building-a-preview/index.md#auto-generate-previews)
  - [Auto-delete Previews](building-a-preview/index.md#auto-delete-previews)
  - [Optimize your Preview builds](building-a-preview/index.md#optimize-your-preview-builds)
  - [Preview size explained](building-a-preview/index.md#preview-size-explained)

* [Setting up Services](setting-up-services/index.md)

  - [How to set up Services](setting-up-services/index.md#how-to-set-up-services-in-tugboat)
    - [Name your Service](setting-up-services/index.md#name-your-service)
    - [Specify a Service image](setting-up-services/index.md#specify-a-service-image)
      - [Docker Hub](setting-up-services/index.md#how-to-call-a-service-image-from-docker-hub)
      - [Tugboat's prebuilt images](setting-up-services/index.md#tugboats-prebuilt-docker-images)
      - [Third-party Docker images](setting-up-services/index.md#third-party-docker-images)
      - [Alternate registries](setting-up-services/index.md#bring-your-own-docker-image-from-another-registry)
      - [Mirroring production](setting-up-services/index.md#using-a-docker-image-to-mirror-your-production-services)
      - [Image pull and update](setting-up-services/index.md#when-does-an-image-get-pulled-or-updated)
    - [Define a default Service](setting-up-services/index.md#define-a-default-service)
    - [Expose a Service HTTP port](setting-up-services/index.md#expose-a-service-http-port)
    - [Set the Document Root Path](setting-up-services/index.md#set-the-document-root-path)
  - [Services options and reference](setting-up-services/index.md#services-options-and-reference)
    - [Cloning Git repositories into your Services](setting-up-services/index.md#cloning-git-repositories-into-your-services)
    - [Using Service Commands](setting-up-services/index.md#service-commands)
    - [Running a Background Process](setting-up-services/index.md#running-a-background-process)
    - [Service Attributes](setting-up-services/index.md#service-attributes)
    - [Prebuilt Service images](setting-up-services/index.md#prebuilt-service-images)
    - [Environment Variables](setting-up-services/index.md#environment-variables)
  - [Services in action](setting-up-services/index.md#services-in-action)

* [Tugboat's CLI](tugboat-cli/index.md)

  - [Install the CLI](tugboat-cli/index.md#install-tugboats-command-line-interface)
  - [Set an Access Token](tugboat-cli/index.md#set-an-access-token)
  - [Commands](tugboat-cli/index.md#review-commands)
  - [Running the CLI in a Preview](tugboat-cli/index.md#running-the-cli-from-a-tugboat-preview)

* [Tugboat Billing](tugboat-billing/index.md)

  - [Tugboat pricing](tugboat-billing/index.md#tugboat-pricing)
    - [How pricing works](tugboat-billing/index.md#how-does-tugboat-pricing-work)
      - [Calculating storage](tugboat-billing/index.md#calculating-project-storage-for-tugboat-billing)
      - [View storage](tugboat-billing/index.md#how-to-view-project-storage)
    - [View Tugboat pricing](tugboat-billing/index.md#to-view-tugboat-pricing-for-your-project)
    - [Tugboat for Enterprise](tugboat-billing/index.md#tugboat-for-enterprise)
  - [Change your Tugboat plan](tugboat-billing/index.md#change-your-tugboat-plan)
  - [Change billing information](tugboat-billing/index.md#change-billing-information)
  - [Cancel billing](tugboat-billing/index.md#cancel-billing)
    - [Change to Free](tugboat-billing/index.md#change-your-tugboat-plan-to-the-free-tier)
    - [Delete project](tugboat-billing/index.md#delete-your-project)

* [Starter Configs](starter-configs/index.md)

  - [Tutorials](starter-configs/index.md#tutorials)
    - [Drupal 7](starter-configs/drupal7/index.md)
    - [Drupal 8](starter-configs/drupal8/index.md)
    - [WordPress](starter-configs/wordpress/index.md)
    - [Pantheon](starter-configs/pantheon/index.md)
  - [Frameworks, CMSs and Sites](starter-configs/index.md#frameworks-cmss-and-sites)
    - [Static HTML](starter-configs/static-html/index.md)
    - [Generic LAMP](starter-configs/generic-lamp/index.md)
  - [Databases](starter-configs/index.md#databases)
    - [Import a MySQL Database](starter-configs/import-mysql-database/index.md)
    - [Add a phpMyAdmin service](starter-configs/phpmyadmin/index.md)
  - [Testing](starter-configs/index.md#testing)
    - [Run Functional Tests](starter-configs/functional-tests/index.md)
    - [SimpleTest](starter-configs/simpletest/index.md)
  - [Utility](starter-configs/index.md#utility)
    - [Warm a Page Cache](starter-configs/page-cache/index.md)
    - [Tenon.io Integration](starter-configs/tenon_io/index.md)

* [Using Visual Diffs](visual-diffs/index.md)

* [FAQ](faq/index.md)

- [Advanced](advanced/index.md)

  - [Custom Environment Variables](advanced/custom-environment-variables/index.md)
  - [Command Line Interface](advanced/cli/index.md)
  - [Start a Background Process](advanced/background-process/index.md)

- [Troubleshooting](troubleshooting/index.md)

- [Help and Support](support/index.md)
