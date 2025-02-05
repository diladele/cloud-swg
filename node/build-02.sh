#!/bin/bash

# check we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install core modules of web safety
pushd scripts
bash 02_squid.sh && \
bash 03_clamav.sh && \
bash 04_websafety.sh && \
bash 05_integrate.sh && \
bash 06_node.sh && \
bash 07_prometheus.sh && \
bash 08_exporter.sh
popd

# tell 
echo "SUCCESS"
echo "SUCCESS"
echo "SUCCESS Now run va.sh script for the appliance or azure-*.sh or aws-*.sh for cloud instances!"
echo "SUCCESS"
echo "SUCCESS"
