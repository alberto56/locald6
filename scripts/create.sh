#!/bin/bash
set -e

./scripts/destroy.sh
docker-compose build
docker-compose up -d
echo ''
echo 'About to import the database, this might take a while...'
docker-compose exec web /run.sh

echo ''
echo 'If all went well you can now access your site at:'
echo ''
echo " => "$(./scripts/uli.sh)
echo ''
echo '(Replace 0.0.0.0 with your own IP, or localhost)'
echo ''
