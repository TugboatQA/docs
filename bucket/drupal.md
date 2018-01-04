# Configuring a Drupal Site
To configure your Tugboat base instance, you’ll need to follow the same steps as setting up a new local instance.

## The Basics
- Add the local `settings.php` file.
- Create and import the databases.

## Multisite
If you are leveraging Drupal’s multisite capabilities, you’ll need to add a line to your `sites.php` file where the hostname format looks like this:  

`[TUGBOAT_TAG]-[TUGBOAT_TOKEN].[TUGBOAT_DOMAIN]`

This will result in a hostname pattern like this:

`pr28-msi2gku2habrovvi.yourproject.tugboat.qa`

### Sites.php Entry
```
# Tugboat sites.
$tugboat = getenv('TUGBOAT_TAG');
if (!empty($tugboat)) {
  $TUGBOAT_URL = getenv('TUGBOAT_TAG') . '-' . getenv('TUGBOAT_TOKEN') . '.' . getenv('TUGBOAT_DOMAIN');
  $sites[$TUGBOAT_URL] = ’site.directory’;
}
```

## Drush Configuration
If you haven’t added your drush aliases to your project repo you can add them to your `~/.drush` directory.  Add a reference to your tugboat base instance like this:

```
$aliases['tugboat'] = array(
  'root' => '/var/lib/tugboat/docroot',
  'uri' => ‘latest-‘ . getenv(‘TUGBOAT_TOKEN’) . ‘.’ . getenv(‘TUGBOAT_DOMAIN’),
);
```

## Acquia Keys
If your site is hosted at Acquia you’ll need to [setup an SSH key ](acquia.md) for Tugboat to sync databases and/or files.