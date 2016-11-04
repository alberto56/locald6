#!/bin/bash
set -e

# You can add MySQL commands here, like this:
# echo 'SOME MYSQL COMMAND;' | mysql --user=root --host=database --port=3306;

cat /settings.php-database >> /var/www/html/sites/default/settings.php

cd /var/www/html && \
  drush sqlc < /var/www/db.sql && \
  drush cc all
