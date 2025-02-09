#!/bin/bash

# this script MUST be run as root user
NAME=`whoami`
if [[ $NAME != "root" ]]; then
    echo "This script must be run as root user" 1>&2
    exit 1
fi

# change into the folder where this script is
cd "$(dirname "$0")"

# recreate the local data folder
if [ -d data ]; then
    rm -rf data
fi
mkdir data

# backup db and repo
bash db.sh
bash repo.sh

# start the compose services
docker compose up -d

# move the data folder to backups
mv data /opt/cloud-swg-console/var/backups/`date +"%Y-%m-%d"`

