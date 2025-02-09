#!/bin/bash

# check we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# make console folder and all its subfolders
mkdir -p /opt/cloud-swg-console/var/log

# copy the binary folder 
cp -r opt/cloud-swg-console /opt

# copy the backup job to the cron
cp etc/cron.d/cloud_swg_console_backup /etc/cron.d

# copy systemd file
cp etc/systemd/system/cloud-swg-console.service  /etc/systemd/system/

# tell systemd to reload
systemctl daemon-reload

# enable and start
systemctl enable cloud-swg-console
systemctl start cloud-swg-console
