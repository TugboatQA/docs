---
title: "Add Repos to the Project"
date: 2019-09-17T11:42:01-04:00
weight: 3
---

Once you've decided how you want to structure your project, add the relevant repos to your project.

### To add repos during project creation:

When you're creating a project, select your repository host from the Provider drop-down, select the Organization, if
applicable, and click the radio button next to the repo you want to add.

![Select Provider and repo](../../_images/add-repos-to-project-select-repo.png)

Alternately, if you're using a generic git server, select Git as the provider, and enter your repo name and Git URL.

![Specify generic git server](../../_images/add-repos-to-project-generic-git-provider.png)

### To add repos to a project you've already created:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.
2. Select the project where you want to add the repo.
3. Go to {{% ui-text %}}Add a Repository{{% /ui-text %}} .

From there, you'll be back to the 'select a provider and specify a repo' screen.

{{% notice info %}} There is no limit to the number of repositories you can add to a Tugboat project. However, you may
be unable to build new Previews within a project, if the total storage used in your project reaches the
[billing tier storage limit for your project](/tugboat-billing/tugboat-pricing/#how-does-tugboat-pricing-work).
{{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.

![My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to add the repo.

![Select the project](../../_images/select-a-project.png)

Go to {{% ui-text %}}Add a Repository{{% /ui-text %}} .

![Go to Add a Repository](../../_images/go-to-add-a-repository.png)

From there, you'll be back to the 'select a provider and specify a repo' screen.

{{% /expand%}}
