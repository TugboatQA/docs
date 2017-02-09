# Introduction

## Captured Email

* Tugboat attempts to capture outbound email
    * Application must use ports 25 or 587 without TLS
    * Containers can be configured with ssmtp to allow local `sendmail` method

```
root=postmaster
mailhub=mail.tugboat.qa
```
