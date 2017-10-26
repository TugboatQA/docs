# Acquia Hosted Sites

If your site is hosted with Acquia and you wish to connect tugboat for the
purpose of syncing databases or other assets, you’ll need to create an ssh key
and add it to an Acquia account.

1. Open the terminal to your webhead container from the Base Preview details
   page

    ![Webhead Terminal](_images/base-terminal.png)

2. Acquia requires a 4096 bit key, so run `ssh-keygen -b 4096 -t rsa`.

3. Follow the prompts using default values. Leave the password field empty.

4. Add the contents of `/root/.ssh/is_rsa.pub` to your Acquia account or the
   account representing the Tugboat admin.

After you’ve added the key to an account on Acquia, test the ssh connection to
any environments you want Tugboat to connect to, so they are added to the
`known_hosts` file.

You can now setup custom automated scripts to downsync data from the Acquia
servers.
