#!/bin/bash
qm create 101 \
  --name alpine-web01 \
  --memory 2048 \
  --cores 2 \
  --cpu host \
  --net0 virtio,bridge=vmbr0 \
  --scsihw virtio-scsi-pci \
  --scsi0 ceph-storage:20 \
  --ide2 ceph-storage:cloudinit \
  --boot order=scsi0 \
  --serial0 socket \
  --vga serial0 \
  --agent enabled=1

  qm set --ciuser administrator \
  --sshkeys /root/authorized_keys \
  --cipassword "p" \
  --ipconfig0 ip=10.6.67.223/24,gw=10.6.67.1 \
  --nameserver 10.6.67.223 \
  --searchdomain example.local