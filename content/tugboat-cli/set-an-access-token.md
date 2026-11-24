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
4. Choose a {{% ui-text %}}Role{{% /ui-text %}} for the Access Token. The default is {{% ui-text %}}Full
   access{{% /ui-text %}}. See [Access Token roles](#access-token-roles).
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

## Access Token roles

Each Access Token has a role. You choose the role when you generate the Access Token, and you can't change it later. The
Access Tokens page shows the role of each token in the {{% ui-text %}}Role{{% /ui-text %}} column.

- {{% ui-text %}}Full access{{% /ui-text %}}: The token can do everything you can do. Access Tokens that you created
  before roles were available have full access.
- {{% ui-text %}}Sandbox agent{{% /ui-text %}}: The token can only work with Sandbox Previews that you own.

When a token's role doesn't permit an operation that you could perform, the API returns error `1163`,
`Access token role does not permit this operation`. For more information, see
[Tugboat Error Codes](/reference/tugboat-error-codes/).

To set the role when you create an Access Token with the CLI, pass `role=full` or `role=sandbox`:

```sh
tugboat create key "My agent" role=sandbox
```
