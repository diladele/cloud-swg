#!/bin/bash

# check we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# stop the console service
systemctl stop cloud-swg-console

# change into installation folder
pushd /opt/cloud-swg-console

# stop the compose just in case again
docker compose down

# and start it again in a detached mode
docker compose up -d

# initialize still empty database
docker compose exec app python manage.py migrate

# load the fixtures into it
docker compose exec app python manage.py loaddata swg/fixtures/initial.json

# and load some default database contents
docker compose exec app python seed.py

# good then stop the compose
docker compose down

# and restart the service
systemctl restart cloud-swg-console

# good
cat << EOF

SUCCESS
SUCCESS $(basename $BASH_SOURCE) - success!
SUCCESS

EOF
