#!/bin/bash

#
# this script is used to seed the empty database once in a lifetime
# we assume the 'docker compose up' runs normally but the database
# is empty for now - after this script database will be fully initialized
#

# comment the following if you need to actuall seed the empty database
# because if you run this script on a live database you will get problems
exit

# first initialize the empty database
docker compose exec app python manage.py migrate

# then load the fixtures
docker compose exec app python manage.py loaddata swg/fixtures/initial.json

# finally load the default database contents
docker compose exec app python seed.py
