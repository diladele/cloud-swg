#!/bin/bash

# all web packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install postgres
apt -y install postgresql postgresql-contrib

# recreate the initial database
sudo -u postgres psql <<- EOSQL1
    DROP DATABASE IF EXISTS cloud_swg; 
    CREATE DATABASE cloud_swg;
EOSQL1

# recreate user
sudo -u postgres psql <<- EOSQL2
    DROP ROLE IF EXISTS cloud_swg;
    CREATE ROLE cloud_swg LOGIN PASSWORD 'cloud_swg';
    GRANT ALL PRIVILEGES ON DATABASE cloud_swg TO cloud_swg;
EOSQL2
