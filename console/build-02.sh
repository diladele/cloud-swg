#!/bin/bash

# check we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install components
pushd scripts
bash 02_docker.sh && \
bash 03_nginx.sh && \
bash 04_console.sh && \
bash 05_seed.sh
popd

# tell 
echo "SUCCESS"
echo "SUCCESS"
echo "SUCCESS Now run va.sh script for the appliance or azure-*.sh or aws-*.sh for cloud instances!"
echo "SUCCESS"
echo "SUCCESS"
