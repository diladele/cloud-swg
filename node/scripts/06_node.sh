#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# for now python scripts run on system level
apt install -y python3-pip

# install all required packages
pip install psutil

# install swg node binary
MAJOR="6.0.0"
MINOR="17FA"
ARCH="amd64"

# download
wget https://packages.diladele.com/cloud-swg-node/$MAJOR.$MINOR/$ARCH/release/ubuntu22/cloud-swg-node-$MAJOR.${MINOR}_$ARCH.deb

# install
dpkg --install cloud-swg-node-$MAJOR.${MINOR}_$ARCH.deb

# run it using the same user as squid
chown -R proxy:proxy /opt/cloud-swg-node
