# Import a MySQL Database

This example assumes that there is a mysqldump file available somewhere via SSH,
and that MySQL is running on a service named "mysql". First, import the Tugboat
Repository's SSH public key to the server hosting the file. Then, add the
following to the repository's Makefile

[import, lang:"makefile", template:"ace"](Makefile)
