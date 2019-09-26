---
title: "Compatible Technologies"
date: 2019-09-26T15:23:53-04:00
weight: 1
---

## Does Tugboat work with...?

Tugboat supports pretty much anything that runs on Linux. Look through our
[prebuilt service images](/setting-up-services/reference/tugboat-images/) to see
what we currently have available. If something that you need is missing, let us
know, and we will work with you to get it added to the list.

People frequently ask about whether Tugboat works with these technologies:

- **Acquia Cloud?** Yes!
- **Pantheon?** Yes! We even have a
  [tutorial](/starter-configs/tutorials/pantheon/) to show you how.
- **GitHub, GitLab, BitBucket?** Yes! Check out:
  [Setting up Tugboat -> Connect with your git provider](/setting-up-tugboat/connect-with-your-provider/)
- **Self-hosted git repositories?** Yes! See:
  [Setting up Tugboat -> Generic git server](/setting-up-tugboat/connect-with-your-provider/#generic-git-server)
- **My own images?** Yes! See:
  [Setting up Services -> Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- **My existing database?** Yes! Take a look at
  [Starter Configs -> Import a MySQL Database](/starter-configs/code-snippets/import-mysql-database/)
  for an example.

## Does Tugboat have a Slack integration?

Tugboat does not currently have a direct Slack integration. However, you can get
very similar functionality if you're using a git integration with Slack:

- [GitHub for Slack](https://github.com/integrations/slack)
- [GitLab Slack Application](https://docs.gitlab.com/ee/user/project/integrations/gitlab_slack_application.html)
- [BitBucket Cloud for Slack](https://confluence.atlassian.com/bitbucket/bitbucket-cloud-for-slack-945096776.html)

With one of these integrations configured, use
[Tugboat's Repository Settings for git provider integrations](/setting-up-tugboat/select-repo-settings/#modify-settings-for-your-github-gitlab-or-bitbucket-integration)
to share details about your Tugboat Previews, such as:

- Set Pull Request Status
- Set Pull Request Deployment Status
- Post Preview Links in Pull Request Comments

When using these settings, Tugboat's updates to your git repository can be
carried through your git Slack integration into your relevant Slack channels.
