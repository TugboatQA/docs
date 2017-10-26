# Upgrading PHP

## To php5.6
1. First, make sure all packages needed to install php are installed.
`$ sudo apt-get update`
`$ sudo apt-get install python-software-properties`

1. Next, add the repository to install php.
   `$ sudo add-apt-repository ppa:ondrej/php5-5.6`

    _If you receive an error that the command `add-apt-repository` is not found, run this command to install it._
    `$ sudo apt-get install software-properties-common`

    Now try the first command again.

1. Run the following commands to make sure all packages are up to date and upgrade to php5.6.
`$ sudo apt-get update`
`$ sudo apt-get upgrade`

1. Most dependent packages may be installed using this format:
`$ sudo apt-get install php5.6-[package]`
Example: `$ sudo apt-get install php5.6-xml`
