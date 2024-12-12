#!/bin/bash

# check we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# change into the scripts folder
pushd scripts
bash 02_apache.sh && \
bash 03_admin.sh && \
bash 04_venv.sh && \
bash 05_integrate.sh
popd

# tell 
echo "SUCCESS"
echo "SUCCESS"
echo "SUCCESS cloud-swg-admin is installed!"
echo "SUCCESS"
echo "SUCCESS"
