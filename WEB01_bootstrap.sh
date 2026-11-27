#!/bin/bash
qm create 201 \
  --name alpine-web01 \
  --memory 2048 \
  --cores 2 \
  --cpu host \
  --net0 virtio,bridge=vmbr0 \
  --scsihw virtio-scsi-pci \
  --ide0 local:iso/alpine.iso,media=cdrom \
  --scsi0 pvepool:20 \
  --ide2 pvepool:cloudinit \
  --boot order=ide0 \
  --serial0 socket \
  --vga serial0 \
  --agent enabled=1

  qm set 201 --ciuser administrator \
  --sshkeys /root/.ssh/authorized_keys \
  --cipassword "p" \
  --ipconfig0 ip=10.6.67.223/24,gw=10.6.67.1 \
  --nameserver 10.6.67.2 \
  --searchdomain example.local