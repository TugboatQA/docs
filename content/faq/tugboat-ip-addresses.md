---
title: "Tugboat IP Addresses"
date: 2019-09-26T15:27:00-04:00
weight: 3
---

Do you need to create an allow list for Tugboat's IP addresses so you can access something behind a firewall? We've got
you covered! Our IPs sometimes change due to maintenance, so here's how you can use `dig` to perform a DNS lookup and
check our IPs:

```sh
$ dig txt +noall +answer  _egress.tugboatqa.com
_egress.tugboatqa.com.	2417	IN	TXT	"69.164.215.171,96.126.107.200,66.175.213.222,104.237.144.198,23.239.12.71,45.33.67.152"
```
