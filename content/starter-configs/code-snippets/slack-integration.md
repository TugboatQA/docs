---
title: "Slack Webhook Integration"
date: Thu, Apr 29 2021
weight: 3
---

Incoming Webhooks are a simple way to post messages from Tugboat into [Slack](https://slack.com/). Creating an Incoming Webhook gives you a unique URL to which you send a JSON payload with the message text and some options. 

## Prerequisites

1. So, you'll need a [Slack](https://slack.com/) account and workspace to post the Tugboat update to. You'll also need a Tugboat account and project. 
2. You'll need to [create a Slack App](https://api.slack.com/messaging/webhooks) from within your Slack account, and enable *Incoming Webhooks*. 
3. In the Slack app settings, and you should now see a new entry under the *Webhook URLs for Your Workspace section*, with a Webhook URL. Copy that URL. We'll import it into Tugboat as an environment variable. The URL will look something like: `https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX`

## Tugboat Repository Configuration

Create a Tugboat [environment variable](/setting-up-services/how-to-set-up-services/custom-environment-variables/) to
store your `SLACK_WEBHOOK_URL`:

## Tugboat config.yml

Use this snippet in your
[configuration file](/setting-up-tugboat/create-a-tugboat-config-file/) to communicate with Slack via the
[service](/setting-up-services/) you want to respond from.

```yaml
services:
  apache:
    commands:
      ready:
        # Send a slack notification.
        - |
          WEBHOOK=$SLACK_WEBHOOK_URL
          PR_URL="https://github.com/$TUGBOAT_REPO/pull/$TUGBOAT_GITHUB_PR"
          DASHBOARD_URL="https://dashboard.tugboat.qa/$TUGBOAT_PREVIEW_ID"
          MESSAGE="*Tugboat URL:* $TUGBOAT_SERVICE_URL\n*PR:* $PR_URL\n*Dashboard:* $DASHBOARD_URL"
          curl -X POST --data-urlencode "payload={\"username\": \"Tugboat\", \"text\": \"$MESSAGE\", \"icon_emoji\": \":tugboat_qa:\"}" "$WEBHOOK"
```

Voila! You Slack integration will look like this:

![Slack Webhook Example](/_images/slack-webhook-example.png)