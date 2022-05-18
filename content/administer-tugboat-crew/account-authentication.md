---
title: "Account Authentication"
date: 2020-04-17T17:00:00-04:00
weight: 6
---

#### Authenticate a Tugboat account

When you create a Tugboat account, you have a few different ways to authenticate:

- [Sign in using a git provider account](#sign-in-using-a-git-provider-account)
- [Sign in using an email address](#sign-in-using-an-email-address)

#### Add authentication methods to a Tugboat account

After you have created a Tugboat account, you can add more forms of authentication:

- [Connect more git provider accounts](#connect-more-git-provider-accounts)
- [Add a password to your email-based login](#add-password-to-email-based-login)
- [Enable two-factor authentication for your email-based login](#enable-two-factor-authentication-for-email-based-login)

#### Change or update authentication

If you want to change an authentication method, you can:

- [Change your password](#change-your-password)
- [Reconfigure two-factor authentication](#reconfigure-two-factor-authentication)
- [Renew two-factor authentication codes](#renew-two-factor-authentication-codes)

#### Disconnect an authentication method

Finally, to remove or disconnect an authentication method:

- [Disconnect a connected git provider account](#disconnect-a-connected-git-provider-account)
- [Disable two-factor authentication for your email-based login](#disable-two-factor-authentication-for-email-based-login)
- [Disable your traditional password](#disable-traditional-password)

## Sign in using a git provider account

For instructions on how to sign in to Tugboat using a git provider account, which for many people is the default way of
creating a Tugboat account, view our [Connect with your provider](/setting-up-tugboat/connect-with-your-provider/) page.
Or for provider-specific instructions, jump right to:

- [GitHub authentication](/setting-up-tugboat/connect-with-your-provider/#github)
- [GitLab authentication](/setting-up-tugboat/connect-with-your-provider/#gitlab)
- [Bitbucket authentication](/setting-up-tugboat/connect-with-your-provider/#bitbucket)

To connect with a [generic git server](/setting-up-tugboat/connect-with-your-provider/#generic-git-server), you'll first
need to [sign in to Tugboat using an email address](#sign-in-using-an-email-address).

## Sign in using an email address

To sign into Tugboat using an email address:

1. Go to the {{% ui-text %}}Sign In{{% /ui-text %}} link (or if this is your first time using Tugboat, go to
   {{% ui-text %}}Create a Free Account{{% /ui-text %}}).
2. You'll be taken to the [Tugboat Dashboard](https://dashboard.tugboatqa.com/), where you should see a
   {{% ui-text %}}Sign in{{% /ui-text %}} pane.
3. Click the {{% ui-text %}}Sign in using your email address{{% /ui-text %}} button.
4. Enter your {{% ui-text %}}Email Address{{% /ui-text %}} and {{% ui-text %}}Password{{% /ui-text %}}, and press the
   {{% ui-text %}}Sign In{{% /ui-text %}} button - or if you haven't signed in with an email address before, click the
   {{% ui-text %}}Sign up{{% /ui-text %}} link and follow the account creation instructions.

{{% notice info %}}If you are already signed into Tugboat via a connected git provider, you'll need to go to
{{% ui-text %}}username -> Sign Out{{% /ui-text %}} at the upper right corner of the
[Tugboat dashboard](https://dashboard.tugboatqa.com/) in order to see the Sign in pane.{{% /notice %}}

{{%expand "Visual Walkthrough" %}}

Go to the {{% ui-text %}}Sign In{{% /ui-text %}} link (or if this is your first time using Tugboat, go to
{{% ui-text %}}Create a Free Account{{% /ui-text %}}).

![Tugboat website sign-in and create account links](../../_images/sign-in-from-tugboat-qa.png)

You'll be taken to the [Tugboat Dashboard](https://dashboard.tugboatqa.com/), where you should see a {{% ui-text %}}Sign
in{{% /ui-text %}} pane.

![Tugboat's Sign In pane](../../_images/tugboat-sign-in-pane.png)

Click the {{% ui-text %}}Sign in using your email address{{% /ui-text %}} button.

![Tugboat's Sign In Pane with arrow pointing to "Sign in using your email address" button](../../_images/click-sign-in-using-your-email-address-button.png)

Enter your {{% ui-text %}}Email Address{{% /ui-text %}} and {{% ui-text %}}Password{{% /ui-text %}}, and press the
{{% ui-text %}}Sign In{{% /ui-text %}} button - or if you haven't signed in with an email address before, click the
{{% ui-text %}}Sign up{{% /ui-text %}} link and follow the account creation instructions.

![Dialog box to enter email address and password, with arrows pointing to "Sign in" and "Sign Up" buttons](../../_images/enter-email-address-and-password-or-click-sign-up.png)

{{% /expand%}}

## Connect more git provider accounts

Whether you've authenticated via a git provider account or an email account, you can always connect additional git
provider accounts to your Tugboat account. We've covered that process in:
[Connect with your provider -> Adding a link to a git provider](/setting-up-tugboat/connect-with-your-provider/#adding-a-link-to-a-git-provider).

## Add password to email-based login

If you signed up for a Tugboat account by authenticating with a git provider account, you won't have a traditional
password on your Tugboat account. As a security best practice, we recommend adding a password to your Tugboat account.

To add a password for email-based login:

1. Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
   select {{% ui-text %}}Profile{{% /ui-text %}}.
2. Go to the {{% ui-text %}}Password{{% /ui-text %}} section of the User Profile, and click
   {{% ui-text %}}Enable{{% /ui-text %}}.
3. Enter and Verify the password you want to use, and press the {{% ui-text %}}OK{{% /ui-text %}} button.

{{%expand "Visual Walkthrough" %}}

Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
select {{% ui-text %}}Profile{{% /ui-text %}}.

![Tugboat Dashboard view with arrow pointing to User drop-down, and then Profile](../../_images/go-to-user-select-profile.png)

Go to the {{% ui-text %}}Password{{% /ui-text %}} section of the User Profile, and click
{{% ui-text %}}Enable{{% /ui-text %}}.

![Tugboat's User Profile pane with Password section circled and an arrow to the enable button](../../_images/go-to-password-click-enable.png)

Enter and Verify the password you want to use, and press the {{% ui-text %}}OK{{% /ui-text %}} button.

![Tugboat's password dialog showing the enter and verify fields, with an arrow pointing to the OK button](../../_images/enter-and-verify-password-press-ok.png)

{{% /expand%}}

## Enable two-factor authentication for email-based login

Once you have [set a password for your email-based login](#add-password-to-email-based-login), you'll have the option to
enable two-factor authentication for your Tugboat account.

To enable two-factor authentication on your Tugboat account:

1. Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
   select {{% ui-text %}}Profile{{% /ui-text %}}.
2. Go to the {{% ui-text %}}Two-Factor Authentication{{% /ui-text %}} section of the User Profile, and click
   {{% ui-text %}}Enable{{% /ui-text %}}.
3. Use a two-factor authentication app on your mobile device to scan the QR code, or manually enter the code into your
   preferred 2FA tool.
4. Enter the 6-digit code from your two-factor authentication app into the dialog box, and press the Verify button.
5. You'll see a list of recovery codes for your account. You can use the {{% ui-text %}}Copy to
   Clipboard{{% /ui-text %}} link to copy the codes. **Make sure you save these in a safe place, as they will not be
   displayed again.** Press the {{% ui-text %}}Close{{% /ui-text %}} button once you've saved the codes.

{{%expand "Visual Walkthrough" %}}

Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
select {{% ui-text %}}Profile{{% /ui-text %}}.

![Tugboat Dashboard view with arrow pointing to User drop-down, and then Profile](../../_images/go-to-user-select-profile.png)

Go to the {{% ui-text %}}Two-Factor Authentication{{% /ui-text %}} section of the User Profile, and click
{{% ui-text %}}Enable{{% /ui-text %}}.

![Tugboat's User Profile pane with Two-Factor Authentication section circled and an arrow to the enable button](../../_images/go-to-two-factor-authentication-and-click-enable.png)

Use a two-factor authentication app on your mobile device to scan the QR code, or manually enter the code into your
preferred 2FA tool.

![View of the Two-Factor Authentication dialog showing the QR code and code manually listed](../../_images/scan-the-qr-code-or-manually-enter-it.png)

Enter the 6-digit code from your two-factor authentication app into the dialog box, and press the Verify button.

![6-digit code typed into dialog box, with arrow pointing to the Verify button](../../_images/type-the-code-and-press-verify.png)

You'll see a list of recovery codes for your account. You can use the {{% ui-text %}}Copy to Clipboard{{% /ui-text %}}
link to copy the codes. **Make sure you save these in a safe place, as they will not be displayed again.** Press the
{{% ui-text %}}Close{{% /ui-text %}} button once you've saved the codes.

![List of Recovery Codes with arrows pointing to the "Copy to Clipboard" element and the "Close" button](../../_images/copy-codes-to-clipboard-and-press-close.png)

{{% /expand%}}

## Change your password

To change the password on your Tugboat account:

1. Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
   select {{% ui-text %}}Profile{{% /ui-text %}}.
2. Go to the {{% ui-text %}}Password{{% /ui-text %}} section of the User Profile, and click
   {{% ui-text %}}Change{{% /ui-text %}}.
3. Enter and Verify your new password, and press the {{% ui-text %}}OK{{% /ui-text %}} button.

{{%expand "Visual Walkthrough" %}}

Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
select {{% ui-text %}}Profile{{% /ui-text %}}.

![Tugboat Dashboard view with arrow pointing to User drop-down, and then Profile](../../_images/go-to-user-select-profile.png)

Go to the {{% ui-text %}}Password{{% /ui-text %}} section of the User Profile, and click
{{% ui-text %}}Change{{% /ui-text %}}.

![Tugboat's User Profile pane with Password section circled and an arrow to the Change button](../../_images/go-to-password-click-change.png)

Enter and Verify your new password, and press the {{% ui-text %}}OK{{% /ui-text %}} button.

![Tugboat's password dialog showing the enter and verify fields, with an arrow pointing to the OK button](../../_images/enter-and-verify-new-password-press-ok.png)

{{% /expand%}}

## Reconfigure two-factor authentication

To reconfigure two-factor authentication for your Tugboat account:

1. Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
   select {{% ui-text %}}Profile{{% /ui-text %}}.
2. Go to the {{% ui-text %}}Two-Factor Authentication{{% /ui-text %}} section of the User Profile, and click
   {{% ui-text %}}Reconfigure{{% /ui-text %}}.
3. Use a two-factor authentication app on your mobile device to scan the QR code, or manually enter the code into your
   preferred 2FA tool.
4. Enter the 6-digit code from your two-factor authentication app into the dialog box, and press the Verify button.
5. You'll see a list of recovery codes for your account. You can use the {{% ui-text %}}Copy to
   Clipboard{{% /ui-text %}} link to copy the codes. **Make sure you save these in a safe place, as they will not be
   displayed again.** Press the {{% ui-text %}}Close{{% /ui-text %}} button once you've saved the codes.

{{%expand "Visual Walkthrough" %}}

Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
select {{% ui-text %}}Profile{{% /ui-text %}}.

![Tugboat Dashboard view with arrow pointing to User drop-down, and then Profile](../../_images/go-to-user-select-profile.png)

Go to the {{% ui-text %}}Two-Factor Authentication{{% /ui-text %}} section of the User Profile, and click
{{% ui-text %}}Reconfigure{{% /ui-text %}}.

![Tugboat's User Profile pane with Two-Factor Authentication section circled and an arrow to the Reconfigure button](../../_images/go-to-two-factor-authentication-and-click-reconfigure.png)

Use a two-factor authentication app on your mobile device to scan the QR code, or manually enter the code into your
preferred 2FA tool.

![View of the Two-Factor Authentication dialog showing the QR code and code manually listed](../../_images/scan-new-qr-code-or-manually-enter-it.png)

Enter the 6-digit code from your two-factor authentication app into the dialog box, and press the Verify button.

![6-digit code typed into dialog box, with arrow pointing to the Verify button](../../_images/enter-new-code-and-press-verify-button.png)

You'll see a list of recovery codes for your account. You can use the {{% ui-text %}}Copy to Clipboard{{% /ui-text %}}
link to copy the codes. **Make sure you save these in a safe place, as they will not be displayed again.** Press the
{{% ui-text %}}Close{{% /ui-text %}} button once you've saved the codes.

![List of Recovery Codes with arrows pointing to the "Copy to Clipboard" UI element and the "Close" button](../../_images/copy-codes-to-clipboard-and-press-close.png)

{{% /expand%}}

## Renew two-factor authentication codes

If you forgot to save your two-factor authentication codes, or have used them all and want new ones, you can use Renew
to generate new codes.

To renew two-factor authentication codes for your Tugboat account:

1. Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
   select {{% ui-text %}}Profile{{% /ui-text %}}.
2. Go to the {{% ui-text %}}Two-Factor Authentication{{% /ui-text %}} section of the User Profile, and click
   {{% ui-text %}}Renew{{% /ui-text %}}.
3. Open your two-factor authentication app, and enter the 6-digit code from it into the Tugboat dialog box.
4. Enter the 6-digit code from your two-factor authentication app into the dialog box, and press the Verify button.
5. You'll see a new list of recovery codes for your account. You can use the {{% ui-text %}}Copy to
   Clipboard{{% /ui-text %}} link to copy the codes. **Make sure you save these in a safe place, as they will not be
   displayed again.** Press the {{% ui-text %}}Close{{% /ui-text %}} button once you've saved the codes.

{{%expand "Visual Walkthrough" %}}

Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
select {{% ui-text %}}Profile{{% /ui-text %}}.

![Tugboat Dashboard view with arrow pointing to User drop-down, and then Profile](../../_images/go-to-user-select-profile.png)

Go to the {{% ui-text %}}Two-Factor Authentication{{% /ui-text %}} section of the User Profile, and click
{{% ui-text %}}Renew{{% /ui-text %}}.

![Tugboat's User Profile pane with Two-Factor Authentication section circled and an arrow to the Renew link](../../_images/go-two-factor-authentication-click-renew.png)

Enter the 6-digit code from your two-factor authentication app into the dialog box, and press the Verify button.

![6-digit code typed into dialog box, with arrow pointing to the Verify button](../../_images/verify-new-2fa-recovery-codes.png)

You'll see a new list of recovery codes for your account. You can use the {{% ui-text %}}Copy to
Clipboard{{% /ui-text %}} link to copy the codes. **Make sure you save these in a safe place, as they will not be
displayed again.** Press the {{% ui-text %}}Close{{% /ui-text %}} button once you've saved the codes.

![List of Recovery Codes with arrows pointing to the "Copy to Clipboard" UI element and the "Close" button](../../_images/copy-new-codes-to-clipboard-and-press-close-button.png)

{{% /expand%}}

## Disconnect a connected git provider account

Do you need to disconnect a git provider account that is linked to your Tugboat account? Take a look at:
[Connect with your provider -> Disconnect a linked git provider](/setting-up-tugboat/connect-with-your-provider/#disconnect-a-linked-git-provider).

## Disable two-factor authentication for email based login

1. Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
   select {{% ui-text %}}Profile{{% /ui-text %}}.
2. Go to the {{% ui-text %}}Two-Factor Authentication{{% /ui-text %}} section of the User Profile, and click
   {{% ui-text %}}Disable{{% /ui-text %}}.
3. You'll see a dialog box asking you to confirm you want to turn off two-factor authentication. Press the
   {{% ui-text %}}OK{{% /ui-text %}} button.

{{%expand "Visual Walkthrough" %}}

Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
select {{% ui-text %}}Profile{{% /ui-text %}}.

![Tugboat Dashboard view with arrow pointing to User drop-down, and then Profile](../../_images/go-to-user-select-profile.png)

Go to the {{% ui-text %}}Two-Factor Authentication{{% /ui-text %}} section of the User Profile, and click
{{% ui-text %}}Disable{{% /ui-text %}}.

![Tugboat's User Profile pane with Two-Factor Authentication section circled and an arrow to the Disable button](../../_images/go-to-two-factor-authentication-click-disable.png)

You'll see a dialog box asking you to confirm you want to turn off two-factor authentication. Press the
{{% ui-text %}}OK{{% /ui-text %}} button.

![Dialog box asking user to confirm turning off two-factor authentication, with an arrow to the OK button](../../_images/disable-2fa-press-ok-button.png)

{{% /expand%}}

## Disable traditional password

If you no longer want to use your email address to login to your Tugboat account, you can disable the traditional
password on your account. When you disable the password on your Tugboat account, you can only login to Tugboat via a
connected git provider account.

To disable the password on your Tugboat account:

1. Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
   select {{% ui-text %}}Profile{{% /ui-text %}}.
2. Go to the {{% ui-text %}}Password{{% /ui-text %}} section of the User Profile, and click
   {{% ui-text %}}Disable{{% /ui-text %}}.
3. You'll see a dialog box asking you to confirm you want to disable your password. Press the
   {{% ui-text %}}OK{{% /ui-text %}} button.

{{%expand "Visual Walkthrough" %}}

Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
select {{% ui-text %}}Profile{{% /ui-text %}}.

![Tugboat Dashboard view with arrow pointing to User drop-down, and then Profile](../../_images/go-to-user-select-profile.png)

Go to the {{% ui-text %}}Password{{% /ui-text %}} section of the User Profile, and click
{{% ui-text %}}Disable{{% /ui-text %}}.

![Tugboat's User Profile pane with Password section circled and an arrow to the Disable button](../../_images/go-to-password-click-disable.png)

You'll see a dialog box asking you to confirm you want to disable your password. Press the
{{% ui-text %}}OK{{% /ui-text %}} button.

![Dialog box asking user to confirm disabling the password, with an arrow to the OK button](../../_images/press-ok-to-confirm-password-disable.png)

{{% /expand%}}
