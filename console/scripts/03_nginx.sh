#!/bin/bash

# check we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install nginx with some other tools
apt -y install mc htop net-tools nginx

# copy nginx config and certificates
cp etc/nginx/sites-available/default     /etc/nginx/sites-available/
cp etc/nginx/sites-available/console.key /etc/nginx/sites-available/
cp etc/nginx/sites-available/console.crt /etc/nginx/sites-available/
cp etc/nginx/sites-available/generate.sh /etc/nginx/sites-available/

# and restart
systemctl restart nginx
