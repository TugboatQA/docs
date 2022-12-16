---
title: "Set an Access Token"
date: 2019-09-19T10:41:45-04:00
weight: 2
---

The first time you attempt to access a Tugboat resource in the Command Line Interface, you'll be asked for an Access
Token.

To set an Access Token:

1. In Tugboat's web interface, go to User Name -> Access Tokens, or
   [click this link](https://dashboard.tugboatqa.com/access-tokens).
2. Click the {{% ui-text %}}Generate New Token option{{% /ui-text %}}.
3. You'll be asked to give the Access Token a description; for example, "Command Line Tool"; enter a description and
   press the {{% ui-text %}}Generate{{% /ui-text %}} button.
4. Make sure you save your Access Token somewhere safe, such as [1Password](https://1password.com/) or other password
   manager.
5. When you run the CLI, and attempt to access a resource, you'll be asked for an Access Token; paste it in and hit `Y`
   to remember it.

{{% notice tip %}} 1Password users can install
[a shell plugin for the 1Password CLI](https://developer.1password.com/docs/cli/shell-plugins/tugboat) so that your
Tugboat token will be encrypted, stored securely, and accessible from any machine. Thank you to Mark Dorison of
[Chromatic](https://chromatichq.com) for contributing this plugin. {{% /notice %}}

Now you're all set to use the Tugboat Command Line Interface!

{{%expand "Visual Walkthrough" %}}

In Tugboat's web interface, go to User Name -> Access Tokens, or
[click this link](https://dashboard.tugboatqa.com/access-tokens).

![Go to Access Tokens page](../../_images/go-to-user-access-tokens.png)

Click the {{% ui-text %}}Generate New Token{{% /ui-text %}} option.

![Click Generate new token](../../_images/generate-new-token.png)

You'll be asked to give the Access Token a description; for example, "Command Line Tool"; enter a description and press
the {{% ui-text %}}Generate{{% /ui-text %}} button.

![Enter token description and press Generate](../../_images/enter-token-description-and-generate.png)

Make sure you save your Access Token somewhere safe, as you won't be able to see it again!

![Copy your new Access Token](../../_images/copy-new-access-token.png)

When you run the CLI, and attempt to access a resource, you'll be asked for an Access Token; paste it in and hit `Y` to
have the CLI remember it.

![Enter the Access Token in the CLI](../../_images/enter-access-token-in-cli.png)

{{% /expand%}}
