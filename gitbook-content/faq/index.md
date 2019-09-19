# Frequently Asked Questions

- [Does Tugboat work with...?](#does-tugboat-work-with)
  - Acquia Cloud?
  - Pantheon?
  - GitHub, GitLab, BitBucket?
  - Self-hosted git repositories?
  - My own images?
  - My existing database?
- [Do you provide production level hosting?](#do-you-provide-production-level-hosting)
- [Can I have SSH access to a preview?](#can-i-have-ssh-access-to-a-preview)
- [How does Tugboat deal with sending email?](#how-does-tugboat-deal-with-sending-email)
- [Does Tugboat have a Slack integration?](#does-tugboat-have-a-slack-integration)
- [What are Tugboat's IPs?](#whitelist-tugboats-ips)

---

## Does Tugboat work with...?

Tugboat supports pretty much anything that runs on Linux. Look through our
[prebuilt service images](../setting-up-services/reference-tugboat-images/index.md)
to see what we currently have available. If something that you need is missing,
let us know, and we will work with you to get it added to the list.

- **Acquia Cloud?** Yes!
- **Pantheon?** Yes! We even have a
  [tutorial](../starter-configs/pantheon/index.md) to show you how.
- **GitHub, GitLab, BitBucket?** Yes! Check out:
  [Setting up Tugboat -> Connect with your git provider](../setting-up-tugboat/index.md#connect-with-your-provider)
- **Self-hosted git repositories?** Yes! See:
  [Setting up Tugboat -> Generic git server](../setting-up-tugboat/index.md#generic-git-server)
- **My own images?** Yes! See:
  [Setting up Services -> Specify a Service image](../setting-up-services/how-to-set-up-services/index.md#specify-a-service-image)
- **My existing database?** Yes! Take a look at
  [Starter Configs -> Import a MySQL Database](../starter-configs/import-mysql-database/index.md)
  for an example.

## Do you provide production-level hosting?

No. Tugboat previews are intended to be short-lived, and do not come with the
stability or support guarantees needed to host a production application.

## Can I have SSH access to a Preview?

No. Direct SSH access to a Preview is not possible. However, shell access is
provided in both the web interface and the
[command line tool](../tugboat-cli/index.md).

## How does Tugboat deal with sending email?

Tugboat makes a best effort to capture outbound email. Using the local
`sendmail` or the SMTP server at `$TUGBOAT_SMTP` will result in email being
captured by Tugboat. These captured emails are only saved for as long as the
Preview that sent them exists.

Tugboat does not attempt to capture any other outbound SMTP server connections,
so if you are concerned with sending emails to customers from a QA environment,
be sure to update your application configuration to use Tugboat's SMTP server.

## Does Tugboat have a Slack integration?

Tugboat does not currently have a direct Slack integration. However, you can get
very similar functionality if you're using a git integration with Slack:

- [GitHub for Slack](https://github.com/integrations/slack)
- [GitLab Slack Application](https://docs.gitlab.com/ee/user/project/integrations/gitlab_slack_application.html)
- [BitBucket Cloud for Slack](https://confluence.atlassian.com/bitbucket/bitbucket-cloud-for-slack-945096776.html)

With one of these integrations configured, use
[Tugboat's Repository Settings for git provider integrations](../setting-up-tugboat/index.md#modify-settings-for-your-github-gitlab-or-bitbucket-integration)
to share details about your Tugboat Previews, such as:

- Set Pull Request Status
- Set Pull Request Deployment Status
- Post Preview Links in Pull Request Comments

When using these settings, Tugboat's updates to your git repository can be
carried through your git Slack integration into your relevant Slack channels.

## Whitelist Tugboat's IPs

Do you need to whitelist Tugboat's IP addresses so you can access something
behind a firewall? We've got you covered! Our IPs sometimes change due to
maintenance, so here's how you can use `dig` to perform a DNS lookup and check
our IPs:

```sh
$ dig txt _egress.tugboat.qa

; <<>> DiG 9.10.6 <<>> txt _egress.tugboat.qa
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 50383
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;_egress.tugboat.qa.        IN    TXT

;; ANSWER SECTION:
_egress.tugboat.qa.    300    IN    TXT    "69.164.208.64,198.74.59.242,96.126.107.6,45.56.103.116"

;; Query time: 339 msec
;; SERVER: 172.16.42.1#53(172.16.42.1)
;; WHEN: Sat Jul 13 00:58:57 CDT 2019
;; MSG SIZE  rcvd: 114
```
