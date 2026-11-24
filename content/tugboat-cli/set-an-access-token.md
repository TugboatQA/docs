---
title: "Set an Access Token"
date: 2019-09-19T10:41:45-04:00
weight: 2
---

The first time you attempt to access a Tugboat resource in the Command Line Interface (CLI), you'll be asked for an
Access Token. You can sign in with your browser and have the CLI save an Access Token for you, or you can create an
Access Token in the dashboard and paste it in.

## Sign in with your browser

To sign in with your browser:

1. Run the following command:

   ```sh
   tugboat login
   ```

2. Press enter to access Tugboat's default dashboard or enter your custom Tugboat Dashboard URL.
3. The CLI opens the Tugboat dashboard in your browser and outputs a code in your terminal. Enter the code output from
   the terminal in the "Device login" page open in your browser, then click {{% ui-text %}}Continue{{% /ui-text %}}.

   ![Screenshot of terminal output showing code to enter and Waiting for approval](/_images/tugboat-login-waiting-for-approval.png)

   ![Screenshot of Device login page shows matching code entered with Continue button](/_images/tugboat-device-login-enter-code.png)

4. The CLI saves a new Access Token with the dashboard URL in the `.tugboat.yml` file in your home directory. The token
   appears on the dashboard's Access Tokens page with the type {{% ui-text %}}CLI login{{% /ui-text %}}.

   ![Screenshot of a list of Access Tokens with new Tugboat CLI access token](/_images/tugboat-access-tokens-list.png)

The dashboard address must use HTTPS. The `tugboat login` command accepts these options:

- `--dashboard=<url>` sets the dashboard address. By default, the CLI uses `https://dashboard.tugboatqa.com`. For
  on-premise Tugboat installations, enter the full https URL of your dashboard, set `TUGBOAT_DASHBOARD`, or set the
  `dashboard` key in the `.tugboat.yml` file in your HOME directory.
- `--no-browser` prints the address instead of opening a browser. Use this when you connect over SSH.

For example, to sign in to an on-premise install:

```sh
tugboat login --dashboard=https://dashboard.example.com
```

## Create an Access Token manually

To create an Access Token in the dashboard and paste it into the CLI:

1. From the Dashboard menu, go to _User Name_ -> [Access Tokens](https://dashboard.tugboatqa.com/access-tokens)
   (_/access-tokens_).
2. Click the {{% ui-text %}}Generate New Token option{{% /ui-text %}}.

   ![Screenshot of a list of Access Tokens with Generate new token highlighted](/_images/access-tokens-generate-new-token-button.png)

3. Provide a description for the access token; for example, "Command Line Tool".
4. Select a role. **Full access** can do everything you can do. **Sandbox agent** can only work with Sandbox Previews
   you own. The role cannot be changed after the token is created.
5. Press the {{% ui-text %}}Generate{{% /ui-text %}} button.

   ![Screenshot of new access token with reminder to copy it now.](/_images/access-token-copy-new-token.png)

6. Make sure you save your Access Token somewhere safe, such as [1Password](https://1password.com/) or other password
   manager.

   {{% notice tip %}} 1Password users can install
   [a shell plugin for the 1Password CLI](https://developer.1password.com/docs/cli/shell-plugins/tugboat) so that your
   Tugboat token will be encrypted, stored securely, and accessible from any machine. Thank you to Mark Dorison of
   [Chromatic](https://chromatichq.com) for contributing this plugin. {{% /notice %}}

7. When you run the CLI, and attempt to access a resource, you'll be asked for an Access Token; paste it in and hit `Y`
   to remember it.

Now you're all set to use the Tugboat Command Line Interface!
