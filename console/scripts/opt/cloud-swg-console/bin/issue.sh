#!/bin/bash

CPUNUM=`cat /proc/cpuinfo | grep processor | wc -l`
RAMNFO=`free -mh | grep Mem: | awk {'print $2, "total,", $4, "free" '}`
DISKSZ=`df -h | grep "/$" | awk {'print $2, "total,", $4, "free" '}`

# some string manupulation magic
OSINFO_TMP1=`cat /etc/os-release | grep ^VERSION=`
OSINFO_NAME=${OSINFO_TMP1#VERSION=}
OSINFO_NAME=${OSINFO_NAME#\"}
OSINFO_NAME=${OSINFO_NAME%\"}

OSINFO_TMP2=`cat /etc/os-release | grep ^NAME=`
OSINFO_DIST=${OSINFO_TMP2#NAME=}
OSINFO_DIST=${OSINFO_DIST#\"}
OSINFO_DIST=${OSINFO_DIST%\"}

echo "Welcome to Cloud SWG Console virtual appliance!"
echo 
echo "Operating System    $OSINFO_DIST, $OSINFO_NAME"
echo "System Kernel       \\r"
echo "System Arch         \\m"
echo "RAM Available       $RAMNFO"
echo "CPU Count           $CPUNUM"
echo "Hard Disk Size      $DISKSZ"
echo
echo "Appliance Version   6.0"
echo "System Username     root"
echo "System Password     Passw0rd"
echo "Installation Dirs   /opt/cloud-swg-console"
echo 
echo "To use this virtual appliance, navigate to the IP address of this machine \\4:80."
echo 
