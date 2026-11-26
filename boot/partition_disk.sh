#!/bin/bash
DISK=/dev/sda
# Skapa en partition på exakt 200 GiB från första lediga sektor
sgdisk -n 0:0:+200G -t 0:8300 -c 0:ceph-osd $DISK
partprobe $DISK