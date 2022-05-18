---
title: "Tugboat Pricing"
date: 2019-09-19T10:49:17-04:00
weight: 1
---

- [How does Tugboat pricing work?](#how-does-tugboat-pricing-work)
  - [Calculating project storage for Tugboat billing](#calculating-project-storage-for-tugboat-billing)
  - [How to view project storage](#how-to-view-project-storage)
- [View Tugboat pricing for your project](#to-view-tugboat-pricing-for-your-project)
- [Tugboat Premium](#tugboat-premium)

## How does Tugboat pricing work?

Tugboat's pricing isn't based on your account, number of users, or on external repositories; Tugboat is priced on a
per-project basis.

When you [Create a New Project](/setting-up-tugboat/create-a-new-project/) in Tugboat, you'll select a plan based on
your [Preview storage](#calculating-project-storage-for-tugboat-billing) and
[build performance](/building-a-preview/preview-deep-dive/optimize-preview-builds/) needs. You can then
[link as many external repositories](/setting-up-tugboat/add-repos-to-the-project/) as you'd like to that project, and
[add as many users](/administer-tugboat-crew/user-admin/#add-a-user-to-a-project) as you'd like, all under the same
plan.

If you later find your project doesn't have enough storage, or your Preview build performance isn't what you need it to
be, you can always [change your Tugboat project's performance tier](../change-tugboat-plan/) - without affecting your
other Tugboat projects.

### Calculating Project storage for Tugboat billing

[Project storage](#how-to-view-project-storage) is calculated by adding the size of all of the Previews contained in a
Tugboat project. This includes any [Base Previews](/building-a-preview/work-with-base-previews/set-a-base-preview/), as
well as additional Previews that have been built from the Base Previews. Tugboat calculates Preview sizes across all
repositories contained in a project when determining project storage, which may be larger than what you see when you're
viewing an individual repository within Tugboat.

![Storage in Repository Stats vs. Project Stats](../../_images/billing-repo-stats-vs-project-stats.png)

{{% notice info %}} Curious about why a Preview is larger than your git repository? The Preview size is the size of the
entire container at the end of the Preview build process. If your Preview build is pulling in large assets, such as
large databases or Service images, your resulting build size includes those assets - not only the code from your linked
git repo. If you want to reduce your Preview size, take a look at our tips in:
[optimize your Preview builds](/building-a-preview/preview-deep-dive/optimize-preview-builds/). {{% /notice %}}

#### How to view project storage

You can view how much storage you've used by going to your Project Dashboard, and looking at the Project Stats section:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat
   dashboard.
2. Select the project where you want to view disk space used.
3. Scroll down to {{% ui-text %}}Project Stats{{% /ui-text %}}.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat dashboard.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to view disk space used.

![Select the project](../../_images/select-a-project.png)

Scroll down to {{% ui-text %}}Project Stats{{% /ui-text %}}.

![Project Stats -> Project Storage](../../_images/billing-project-stats-project-storage.png)

{{% /expand%}}

## To view Tugboat pricing for your project:

If you're a current Tugboat user, here's how to view the pricing for your project:

1. Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat
   dashboard.
2. Select the project where you want to view and administer billing.
3. Go to {{% ui-text %}}Project Settings{{% /ui-text %}}.
4. Scroll down to {{% ui-text %}}Your Plan{{% /ui-text %}}.

From here, you'll see the pricing tiers available for your plan. You can
[change performance tiers](../change-tugboat-plan/), or [Delete the Project](../cancel-billing/#delete-your-project) if
you're finished using Tugboat for that project.

If you don't have a Tugboat project, you can view current Tugboat pricing here:
[Pricing](https://www.tugboatqa.com/pricing/).

{{% notice note %}} If you're looking for Tugboat Premium and Premium On-Premise, see:
[Tugboat Premium](#tugboat-premium). {{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboatqa.com/projects) at the upper-right of the Tugboat dashboard.

![Go to username -> My Projects](../../_images/go-to-user-my-projects.png)

Select the project where you want to view and administer billing.

![Select the project](../../_images/select-a-project.png)

Go to {{% ui-text %}}Project Settings{{% /ui-text %}}.

![Go to Project Settings](../../_images/click-project-settings-link.png)

Scroll down to {{% ui-text %}}Your Plan{{% /ui-text %}}.

![Scroll down to Your Plan](../../_images/billing-view-tugboat-plan.png)

{{% /expand%}}

## Tugboat Premium

If you need dedicated hardware or to host on-premise, we've got [Tugboat Premium](https://www.tugboatqa.com/premium) for
you! Tugboat's Premium version comes with significantly more Preview storage and RAM, and can be hosted in Tugboat's
Cloud or behind your firewall.

To learn more and change your Tugboat Premium plan, [contact us](https://www.tugboatqa.com/contact).
