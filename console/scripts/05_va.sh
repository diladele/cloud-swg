#!/bin/bash

# check we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#
# detect and install vmware tools
#
dmidecode -s system-product-name | grep -i "vmware" > /dev/null
if [ $? -eq 0 ]; then
    
   echo "Detected VMware, installing open-vm-tools..."
   apt update > /dev/null
   apt install -y open-vm-tools

   # reset the machine-id to force different dhcp addreses upon boot - https://kb.vmware.com/s/article/82229
   echo -n > /etc/machine-id
   rm /var/lib/dbus/machine-id
   ln -s /etc/machine-id /var/lib/dbus/machine-id
fi


# install va scripts
# pushd appliance/va
# bash 01_login.sh && bash 02_harden.sh
# popd

# change working dir into root
# cd /root

# remove the build user completely
# deluser --remove-home builder

# tell 
echo "SUCCESS"
echo "SUCCESS"
echo "SUCCESS --- Cloud SWG Admin virtual machine is ready, do NOT REBOOT ANY MORE, just export it --"
echo "SUCCESS"
echo "SUCCESS"

# and shutdown
cd /root && shutdown -h now
