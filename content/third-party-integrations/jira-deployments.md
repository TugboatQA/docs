---
title: "Jira Deployments"
date: 2024-08-21T17:00:00-04:00
weight: 15
---

## Overview
If you're using Jira as a ticket management system, and a VCS like GitHub, this tutorial will show you how to configure Jira to register Tugboat previews as deployments and attach related information to your Jira issues.  Your Jira issues will show the status of the deployment and the relative environment, allowing users to manually verify whether an issue was successfully deployed, and for admins to set up Jira automations to use those deployments as triggers to act on issues. 

### What This Won't Do
This doesn't post links on issues to the resulting Tugboat preview environment URL.

## Prerequisites
1. An Atlassian account with an active Jira project.
2. A repository on a VCS that integrates with Jira (ex: GitHub, BitBucket).
3. Jira configured with the VCS integration enabled and deployments turned on.

[TODO: add screenshots]

## Background Info
