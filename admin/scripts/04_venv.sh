#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# update and upgrade just in case again
apt update && apt -y upgrade

# install various required python packages from the system repo
apt install -y python3-dev python3-openssl zlib1g-dev libssl-dev python3.12-venv

# create a virtual environment
python3 -m venv /opt/cloud-swg-admin/env

# install required packages into virtual environment
/opt/cloud-swg-admin/env/bin/pip3 install -r /opt/cloud-swg-admin/requirements.txt
