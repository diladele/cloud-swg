#!/bin/bash

# this script MUST be run as root user
NAME=`whoami`
if [[ $NAME != "root" ]]; then
   echo "This script must be run as root user" 1>&2
   exit 1
fi

# check the repo.tar.gz is manually copied here
if [ ! -f repo.tar.gz ]; then
    echo "Please manually copy the repo.tar.gz to restore into this folder and run this script again." 1>&2
    exit 1
fi

# remake the temporary folder
rmdir ./ztmp 
mkdir ./ztmp 

# stop on any error
set -e

# untar into temporary folder
tar -xvf repo.tar.gz -C ./ztmp

# see if repo exists
if [ -d /opt/cloud-swg-admin/var/repo ]; then

   # remove the bak    
   rm -Rf /opt/cloud-swg-admin/var/repo.bak 

   # move current to bak
   mv /opt/cloud-swg-admin/var/repo /opt/cloud-swg-admin/var/repo.bak 
fi

# move temp to repo
mv ./ztmp/opt/cloud-swg-admin/var/repo /opt/cloud-swg-admin/var

# and finally reset the owner
chown -R proxy:proxy /opt/cloud-swg-admin