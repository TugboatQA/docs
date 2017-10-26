# Makefile Examples

### Referencing scripts
```
tugboat-init:
	util/tugboat/init.sh

tugboat-update:
	util/tugboat/update.sh

tugboat-build:
	util/tugboat/build.sh
```

### Simple npm and grunt

**Makefile**
```
install:
	npm install
	npm run build
tugboat-update: install
tugboat-build: install
```

**package.json**
```json
{
...
  "scripts": {
    "build": "grunt"
  },
...
}
```

### Simple git submodule update

```
tugboat-build:
	git submodule update

tugboat-update: tugboat-build
```

*Note how the tugboat-update command references the tugboat-build command to run the same command during both execution points.*
