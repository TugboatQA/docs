# CasperJS for Testing

Open the termiinal to your webhead container from the Base Preview details page

![Webhead Terminal](_images/base-terminal.png)

Installing applications with apt.

```sh
apt-get update
apt-get install phantomjs
apt-get install python
```

Installing from GitHub.

```sh
cd /usr/local/share
git clone https://github.com/n1k0/casperjs.git
ln -s /usr/local/share/casperjs/bin/casperjs /usr/local/bin/casperjs
```

Commit the changes you've just made to the Base Preview so that future builds
will also include those changes.

![Action Menu](_images/base-actions.png)
