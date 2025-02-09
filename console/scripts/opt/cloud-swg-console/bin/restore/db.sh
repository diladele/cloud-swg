#!/bin/bash

# this script MUST be run as root user
NAME=`whoami`
if [[ $NAME != "root" ]]; then
    echo "This script must be run as root user." 1>&2
    exit 1
fi

# check the database.sql.gz which we need to restore exists
if [ ! -f data/database.sql.gz ]; then
    echo "Please manually put the database.sql.gz into ./data folder and run this script again." 1>&2
    exit 1
fi

# step 0 - stop all running services to prevent simultaneous writes
docker compose down

# from now on stop on any error
set -e

# unzip the backup file to get the database.sql file
gunzip -c data/database.sql.gz >data/database.sql

# forcefully remove the old docker volume - note all old data is lost!!!
docker volume rm -f cloud-swg-console_postgres

# remove the same volume in development environment too so that we can just use this script in development too
docker volume rm -f cloud-swg-admin_postgres

# start only the database service in detached mode - as no volume exists the
# compose automatically create the empty volume and database service will
# initialize with an empty database
docker compose up db -d

# copy the unpacked sql into the running db container
docker compose cp data/database.sql db:/database.sql

# and run the restore command in that same container - note to pass the redirection
# command into the container and redirect within the container, we use /bin/bash -c 
# construction

# strange - if we run this command manually it works - but if we uncomment it 
# here in this shell file it does not work???? strange
docker compose exec db sh -c 'psql -U postgres <database.sql'

# stop the compose once again
# docker compose down

echo "SUCCESS:"
echo "NOW RUN MANUALLY docker compose exec db sh -c 'psql -U postgres <database.sql'"
#echo "SUCCESS: Database is restored from backup"
echo "SUCCESS:"
