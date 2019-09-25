---
title: "Cancel Billing"
date: 2019-09-19T10:50:09-04:00
weight: 4
---

There are a few ways you can cancel billing for your Tugboat project:

- [Change your Tugboat plan to the Free tier](#change-your-tugboat-plan-to-the-free-tier)
- [Delete your project](#delete-your-project)

### Change your Tugboat plan to the Free tier

If you want to downgrade your Tugboat billing, but still keep using Tugboat, you
can change your Tugboat plan to the Free tier. Follow
[the instructions to change your Tugboat plan](../change-tugboat-plan/), and
select the Free tier.

{{% notice note %}} If you downgrade your Tugboat plan, the changes will take
effect when the currently paid cycle is complete. Whenever you view the **Your
Plan** section of **Project Settings**, you'll see a banner containing the date
that the change will take effect. If your
[project storage](../tugboat-pricing/#calculating-project-storage-for-tugboat-billing)
is over the limit of the lower-level tier, you won't be able to build any new
Previews until you've freed up enough space to put you under that storage limit.
{{% /notice %}}

### Delete your project

If you don't need your Tugboat Previews anymore, or are finished using Tugboat
for a particular project, you can always delete your project:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat dashboard.
2. Select the project you want to delete.
3. Go to {{% ui-text %}}Project Settings{{% /ui-text %}}.
4. Scroll down past {{% ui-text %}}Your Plan{{% /ui-text %}}.
5. Click the red {{% ui-text %}}Delete Project{{% /ui-text %}} button.

{{% notice note %}} When you delete a Tugboat project, you're only deleting the
Previews and Tugboat repositories for that project. This does not affect data in
your git repositories. This also does not affect other Tugboat projects; if you
have three projects in Tugboat, for example, and you delete one of them, you can
still continue working in the other two projects. {{% /notice %}}

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat dashboard.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project you want to delete.

![Select the project](../../_images/select-a-project.png)

Go to {{% ui-text %}}Project Settings{{% /ui-text %}}.

![Go to Project Settings](../../_images/click-project-settings-link.png)

Scroll down past {{% ui-text %}}Your Plan{{% /ui-text %}}.

![Scroll down past Your Plan](../../_images/billing-scroll-past-your-plan.png)

Click the red {{% ui-text %}}Delete Project{{% /ui-text %}} button.

![Click the Delete Project button](../../_images/billing-delete-project.png)
