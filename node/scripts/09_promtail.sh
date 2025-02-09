#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install this version of exporter
VERSION="3.3.2"

# download
wget https://github.com/grafana/loki/releases/download/v${VERSION}/promtail-linux-amd64.zip

# extract contents and remove original archive
unzip promtail-linux-amd64.zip && rm promtail-linux-amd64.zip

# move to bin
mv promtail-linux-amd64 /usr/local/bin/promtail

# create the configuration folder
mkdir /etc/promtail

# return to parent folder
popd

# and check promtail is installed
promtail --version

# our promtail will run as proxy user as all our daemons
chown -R proxy:proxy /etc/promtail

# create systemctl service file
cat >/etc/systemd/system/promtail.service << EOL
[Unit]
Description=Promtail Service
Wants=network-online.target
After=network-online.target

[Service]
User=proxy
Group=proxy
Type=simple
Restart=on-failure
RestartSec=5s
StandardOutput=append:/opt/cloud-swg-node/var/log/promtail.log
StandardError=append:/opt/cloud-swg-node/var/log/promtail.log
ExecStart=/usr/local/bin/promtail -config.file=/etc/promtail/promtail.yml

[Install]
WantedBy=multi-user.target
EOL

# reload the systemd, enable the service and check its status
systemctl daemon-reload
systemctl enable promtail
systemctl restart promtail

# good then
systemctl status promtail
