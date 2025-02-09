#!/bin/bash

# check we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#
# install vm tools (only if vmware is detected)
#
dmidecode -s system-product-name | grep -i "vmware" > /dev/null
if [ $? -eq 0 ]; then
    
        echo "Detected VMware, installing open-vm-tools..."
        apt update > /dev/null
        apt install -y open-vm-tools

        # reset the machine-id to force different dhcp addreses - https://kb.vmware.com/s/article/82229
        echo -n > /etc/machine-id
        rm /var/lib/dbus/machine-id
        ln -s /etc/machine-id /var/lib/dbus/machine-id
fi

# for POC we still allow root login for ssh
sed -i "s/#\{0,1\}PermitRootLogin *.*$/PermitRootLogin yes/g" /etc/ssh/sshd_config

# enable and start issue updating service
systemctl enable cloud-swg-issue && systemctl start cloud-swg-issue

# reset system root password to match documented one
echo root:Passw0rd | chpasswd

# disable the user we used to build the virtual appliance
passwd builder -l

# TODO: this does not work :(
# change working dir into root
# cd /root
# remove the build user completely
# deluser --remove-home builder

# tell 
echo "SUCCESS"
echo "SUCCESS"
echo "SUCCESS --- Cloud SWG Virtual Appliance is ready, do NOT REBOOT ANY MORE, just export as VA --"
# cat /opt/websafety/etc/license.pem | grep "Not After"
echo "SUCCESS"
echo "SUCCESS"
echo "SUCCESS"

# and shutdown after 1 minute
cd /root && shutdown -h now
