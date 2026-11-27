#!/bin/bash

#Security net to ensure command shell is not running in a temporary state ex (chroot)
export PATH=$PATH:/usr/sbin:/sbin
exec > /var/log/firstboot-custom.log 2>&1
set -x

cat > /etc/apt/sources.list.d/proxmox.sources <<'EOF'
Types: deb
URIs: http://download.proxmox.com/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
EOF

echo "Enabled: no" >> /etc/apt/sources.list.d/pve-enterprise.sources

DISK=/dev/sda
sgdisk -n 0:0:+200G -t 0:8300 -c 0:ceph-osd $DISK

# Get partition number
NUM=$(sgdisk -p $DISK | awk '/ceph-osd/ {print $1}' | tail -1)

# Register the new parition to the kernel
partx -a -n "$NUM" $DISK || partx -u $DISK
udevadm settle

lsblk $DISK
exit 0