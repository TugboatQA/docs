# Install PHP 7.2

```
tugboat-init:
    apt-get install -y python-software-properties software-properties-common
    add-apt-repository -y ppa:ondrej/php
    apt-get update
    apt-get install -y php7.2
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```
