#!/usr/bin/env bash
# Generate a new ramdom uuid the first time you create a project.
# You could use the `uuidgen` bash command to get new one!!.
SITE_UUID="ce4965a0-270c-43fd-8793-eb5d681874f6"
chirripo drush cc drush
echo "Installing the site..."
chirripo drush si -- bloom --account-pass=admin --site-name="New Drupal Site" -y
echo "Setting the site uuid..."
chirripo drush config:set -- system.site uuid "$SITE_UUID" -y
if [ -f ./config/sync/core.extension.yml ]; then chirripo drush cim -- -y; chirripo drush cim -- -y; fi

# Change CUSTOMTHEME by your own theme folder.
if [ -f ./themes/custom/CUSTOMTHEME/package.json ]; then
  cd ./themes/custom/CUSTOMTHEME
  if [ ! -d ./node_modules ]; then npm install; fi
  npm run build
fi

echo "Cleaning cache..."
chirripo drush cr
