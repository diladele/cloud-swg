#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# configure params
MAJOR="6.0.0"
MINOR="9519"
ARCH="amd64"

# download
wget https://packages.diladele.com/cloud-swg-admin/$MAJOR.$MINOR/$ARCH/release/ubuntu22/cloud-swg-admin-$MAJOR.${MINOR}_$ARCH.deb

# install
dpkg --install cloud-swg-admin-$MAJOR.${MINOR}_$ARCH.deb
