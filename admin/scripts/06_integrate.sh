#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# enable HTTPS module in apache
a2enmod ssl

# disable the default site and enable admin one
a2dissite 000-default
a2ensite cloud-swg-admin

# finally restart all daemons
service apache2 restart

# start the realtime and history daemons
systemctl start cloud-swg-realtime
systemctl start cloud-swg-history

