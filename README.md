Local Drupal 6
=====

Gives you a local Drupal 6 environment based on a codebase and database.

Requirements
-----

 * Docker (latest version).
 * A dump of the database.
 * A directory containing your Drupal 6 site.

Usage
-----

 * Download this project, for example into `~/locald6`, so that the `create.sh`
   script is at `~/locald6/scripts/create.sh`;
 * Put the database in `~/locald6/db.sql`;
 * Put the complete Drupal 6 site into `~/locald6/public` so that the directory
   `~/locald6/public/sites/default` exists;
 * If `~/locald6/sites/default/settings.php` is not present in your site
   directory, create it by running `sudo cp
   ~/locald6/sites/default/default.settings.php
   ~/locald6/sites/default/settings.php`;
 * Make sure `~/locald6/sites/default/settings.php` is writable by the
   current user;
 * Run `./scripts/create.sh`;
