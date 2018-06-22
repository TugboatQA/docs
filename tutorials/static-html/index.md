# Static HTML

A static HTML site serves files exactly as they are in the git repository.

## Tugboat Configuration

Let's start with the complete working configuration. This file needs to reside
in `.tugboat/config.yml` in the root of your git repository. From there, we will
step through it to explain what is going on. Then, you can customize it as
needed.

```yaml
services:
  apache:
    image: tugboatqa/httpd
    commands:
      init:
    	- ln -sf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"
```

### Apache Service

We chose to use Apache to serve our static HTML site. By not specifying an httpd
version, we will always get the latest available version of Apache.

```yaml
image: tugboatqa/httpd
```

No further configurations are required other than linking up the document root
to the expected path. Our web content lives in the `/docroot` directory in our
git repository, so we create a symlink there.

```yaml
init:
  - ln -sf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"
```

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you
can start building previews!
