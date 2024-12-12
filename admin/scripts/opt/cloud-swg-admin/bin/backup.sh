#!/bin/bash

# stop on any error
set -e

# this script MUST be run as builder user
#NAME=`whoami`
#if [[ $NAME != "builder" ]]; then
#   echo "This script must be run as builder user (like bash $0)" 1>&2
#   exit 1
#fi

# this is the top backups folder
today=$(date +"%Y%m%d_%H%M%S")
top_dir=/opt/cloud-swg-admin/var/backups
bak_dir="$top_dir/$today"
opt_dir=/opt/cloud-swg-admin

# make the backup folder if it does not exist
mkdir -p $bak_dir

# set working folder
pushd $bak_dir >/dev/null

# this is today
echo "Backup script for ${today} is starting..."

# copy the sqlite database
mkdir -p var/db/ && cp "$opt_dir/var/db/db.sqlite" var/db/

# copy the repo folder completely
tar czf repo.tar.gz "$opt_dir/var/repo"


#
#
#

#
# backup postgres
#
#dump="diladele_defs.$now.dump"

#echo "Backing up database to $dump..."
#pg_dump -F t diladele_defs > "$dump.tar"
#if [ $? -eq 0 ]; then
#    gzip "$dump.tar"
#    echo "SUCCESS!"
#else
#    echo "FAILURE!" 
#    echo "FAILURE!" 
#    echo "FAILURE!" 
#fi

echo "Backup script for ${today} completed successfully"

# ok then
popd >/dev/null
