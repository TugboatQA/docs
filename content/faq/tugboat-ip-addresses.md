---
title: "Tugboat IP Addresses"
date: 2019-09-26T15:27:00-04:00
weight: 3
---

Do you need to create an allow list for Tugboat's IP addresses so you can access something behind a firewall? We've got
you covered! Our IPs sometimes change due to maintenance, so here's how you can use `dig` to perform a DNS lookup and
check our IPs:

```sh
$ dig txt +noall +answer  _egress.tugboat.qa
_egress.tugboat.qa.	2417	IN	TXT	"198.74.59.242,96.126.107.6,45.56.103.116,45.79.187.95,50.116.61.225,45.79.132.116,66.228.45.165"
```
