---
title: "Terminal Aliases and Programs"
date: 2023-07-17T17:00:00-04:00
weight: 1
---

If you use the Terminal utility in Tugboat's previews, then it might be helpful to customize it, such as adding aliases and linking programs into the $PATH.  Here's how you can do that from your `config.yml` file.

```yaml
  php:
    image: tugboatqa/php:8
    commands:
      init:
        # Create the standard long-list "ll" alias.
        - echo "alias ll='ls -la'" >> /root/.bashrc
          
        # If using composer, add the path to our "/vendor/bin" directory to the $PATH so we can call those programs
        # without typing out the full path.
        - echo "export PATH=$PATH:${TUGBOAT_ROOT}/vendor/bin" >> /root/.bashrc
```
