#!/bin/bash

#
# this script is used to seed the empty database once in a lifetime
# we assume the 'docker compose up' runs normally but the database
# is empty for now - after this script database will be fully initialized
#

# 
# DO NOT RUN THIS SCRIPT ON YOUR PRODUCTION DATABASE - ONLY ON FIRST DEPLOYMENT
#

# first initialize the empty database
docker compose exec app python manage.py migrate

# then load the fixtures
docker compose exec app python manage.py loaddata swg/fixtures/initial.json

# finally load the default database contents
docker compose exec app python seed.py
