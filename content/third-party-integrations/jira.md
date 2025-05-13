---
title: "Jira Environment Mapping"
date: 2025-05-13T11:00:00-04:00
weight: 40
---

Integrate Tugboat with [Jira](https://www.atlassian.com/software/jira) using the
[GitHub for Jira](https://github.com/atlassian/github-for-jira/blob/main/docs/deployments.md#environment-mapping) plugin
to map your deployment environments. This ensures that deployments from Tugboat (and other environments) are displayed
with the correct labels in Jira, making it easier to track where your code is running.

## Prerequisites

- A GitHub repository with
  [environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
  set up (e.g., Dev, Test, Tugboat, Production Host).
- Jira Cloud instance with the [GitHub for Jira](https://github.com/atlassian/github-for-jira) app installed and
  connected to your GitHub organization.

## Configure Environment Mapping

By default, Jira may show deployments as "unmapped" unless you configure environment mapping. To fix this:

1. **Add a `.jira/config.yml` file to your repository root:**

   ```yaml
   deployments:
     environmentMapping:
       development:
         - "Dev"
       testing:
         - "Tugboat"
       staging:
         - "Test"
       production:
         - "Production Host"
   ```

   - Deployments to **Dev** will show as **Development** in Jira.
   - Deployments to **Tugboat** will show as **Testing** in Jira.
   - Deployments to **Test** will show as **Staging** in Jira.
   - Deployments to **Production Host** will show as **Production** in Jira.

   _Tip: Adjust the mapping to fit your workflow. For example, if you consider Tugboat a staging environment, map it
   under `staging` instead of `testing`._

2. **Result in Jira**

   Once configured, deployments will appear in Jira under the correct environment labels. For example, a deployment to
   Tugboat will show up as "Testing" in Jira.

   ![Example screenshot of deployment mapping in Jira](https://private-user-images.githubusercontent.com/66118/358018257-834857fc-fae1-47cd-beef-02f2b8e34fdb.png)

## References

- [GitHub for Jira: Environment Mapping Documentation](https://github.com/atlassian/github-for-jira/blob/main/docs/deployments.md#environment-mapping)
- [Original Issue Discussion](https://github.com/TugboatQA/docs/issues/394)
