#!/bin/bash

cat > /etc/apt/sources.list.d/proxmox.sources <<'EOF'
Types: deb
URIs: http://download.proxmox.com/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
EOF

echo "Enabled: no" >> /etc/apt/sources.list.d/pve-enterprise.sources
echo "Enabled: no" >> /etc/apt/sources.list.d/ceph.soruces

apt install parted -y

DISK=/dev/sda
# Skapa en partition på exakt 200 GiB från första lediga sektor
sgdisk -n 0:0:+200G -t 0:8300 -c 0:ceph-osd $DISK
partprobe $DISK

exit 0
