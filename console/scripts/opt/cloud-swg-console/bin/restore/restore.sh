#!/bin/bash

# this script MUST be run as root user
NAME=`whoami`
if [[ $NAME != "root" ]]; then
    echo "This script must be run as root user." 1>&2
    exit 1
fi

# check the database.sql.gz which we need to restore is manually copied in this same folder
if [ ! -f database.sql.gz ]; then
    echo "Please manually put the database.sql.gz into this folder and run this script again." 1>&2
    exit 1
fi

###############################################################################
#
# step 0 - stop all running services to prevent simultaneous writes
#
###############################################################################

# stop the docker compose services in production server
systemctl stop cloud-swg-meta

# stop the docker compose services in development server - note the docker
# compose file is in the parent folder, but it also work if we run this command
# from this folder - most probably the docker compose just searches the parent
# folders too
docker compose down

# from now on stop on any error
set -e

###############################################################################
#
# database restore section
#
###############################################################################

# create a folder which will hold the unpacked sql file
mkdir unpacked

# unzip the backup file to get the database.sql file
gunzip -c database.sql.gz >unpacked/database.sql

# now forcefully remove the old docker volume - note all old data is lost
docker volume rm cloud-swg-db

# start only the database service in detached mode - as no volume exists the
# compose automatically create the empty volume and database service will
# initialize with an empty database
docker compose up db -d


docker compose cp unpacked/database.sql db:/restore
docker compose exec db /usr/bin/pg_restore -d postgres /restore/database.sql

# run a temporary container in docker using postgres:12 image we have locally
# and attach the unpacked folder to it, then run the database restore script
# in that container which will restore database.sql file to our db container
docker run --rm \
    -v unpacked:/unpacked \
    postgres:12 /usr/bin/pg_restore -v /unpacked/database.sql -u db -u postgres


docker exec -i bin-db-1 pg_restore -U postgres -v -d postgres < artefacts/database.sql

# stop the compose once again
docker compose down

# and now start the docker compose services in production server
systemctl start cloud-swg-meta

echo "SUCCESS:"
echo "SUCCESS: Database is restored from backup"
echo "SUCCESS:"
