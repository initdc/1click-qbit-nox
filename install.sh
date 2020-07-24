#!/bin/sh

set -e

sudo apt update
sudo apt install -y qbittorrent-nox
sudo adduser --system --group qbittorrent-nox
sudo adduser www-data qbittorrent-nox

sudo cat <<EOF >>/etc/systemd/system/qbittorrent-nox.service
[Unit]
Description=qBittorrent Command Line Client
After=network.target

[Service]
#Do not change to "simple"
Type=forking
User=qbittorrent-nox
Group=qbittorrent-nox
UMask=007
ExecStart=/usr/bin/qbittorrent-nox -d --webui-port=8080
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable qbittorrent-nox
read -p 'Input y to agree the qbit user agreement, then quit and run::: sudo systemctl start qbittorrent-nox' a
qbittorrent-nox
