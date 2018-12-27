#!/bin/sh
vg="linux"

# create partition table on /dev/sda and /dev/sdb, at the end, install boot-loader on both.

if [ "$1" = "--create-raid" ]; then
    mdadm --create /dev/md0 --level 1 --raid-devices 2 /dev/sda1 /dev/sdb1
fi

pvcreate /dev/md0
vgcreate $vg /dev/md0

lvcreate $vg -n boot -L1G
lvcreate $vg -n root -L5G
lvcreate $vg -n usr -L5G
lvcreate $vg -n var -L20G
lvcreate $vg -n home -L50G

mkfs.ext2 /dev/$vg/boot
mkfs.ext4 /dev/$vg/root
mkfs.ext4 /dev/$vg/usr
mkfs.ext4 /dev/$vg/var
mkfs.ext4 /dev/$vg/home

mount /dev/$vg/root /mnt && mkdir /mnt/boot
mount /dev/$vg/boot /mnt/boot

mkdir /mnt/var /mnt/usr /mnt/home /mnt/dev /mnt/proc /mnt/sys

mount /dev/$vg/usr /mnt/usr
mount /dev/$vg/var /mnt/var
mount /dev/$vg/home /mnt/home

mount -o bind /dev /mnt/dev
mount -o bind /dev/pts /mnt/dev/pts
mount -o bind /proc /mnt/proc
mount -o bind /sys /mnt/sys

debootstrap --arch=amd64 --include=linux-image-amd64,grub2 wheezy /mnt
