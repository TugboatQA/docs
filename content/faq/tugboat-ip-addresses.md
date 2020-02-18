---
title: "Tugboat IP Addresses"
date: 2019-09-26T15:27:00-04:00
weight: 3
---

Do you need to whitelist Tugboat's IP addresses so you can access something behind a firewall? We've got you covered!
Our IPs sometimes change due to maintenance, so here's how you can use `dig` to perform a DNS lookup and check our IPs:

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
