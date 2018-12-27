gpart destroy ada0
gpart create -s gpt ada0
gpart add -t freebsd-boot -s 128 ada0
gpart add -t freebsd-swap -s 4G ada0
gpart add -t freebsd-zfs -l FBSD-ZROOT ada0
dd if=/dev/zero of=/dev/ada0p3 count=560 bs=512
gpart bootcode -b /boot/pmbr -p /boot/gptzfsboot -i 1 ada0
zpool create -f -m none -o altroot=/mnt -o cachefile=/tmp/zpool.cache tank gpt/FBSD-ZROOT
zfs create -o mountpoint=/ tank/root
zfs create -o mountpoint=/usr tank/usr
zfs create -o mountpoint=/var tank/var
zfs create -o mountpoint=/tmp tank/tmp
zfs create -o mountpoint=/usr/home tank/usr/home
zpool set bootfs=tank/root tank

#exit, let sysinstall install the system, then go to Live CD mode.

echo "/dev/ada0p2 none swap sw 0 0" > /mnt/etc/fstab
echo "zfs_enable=\"YES\"" > /mnt/etc/rc.conf
echo "opensolaris_load=\YES\"" > /mnt/boot/loader.conf
echo "zfs_load=\YES\"" > /mnt/boot/loader.conf
echo "vfs.root.mountfrom=\"zfs:tank/root\"" >> /mnt/boot/loader.conf

zpool export tank
zpool import -o altroot=/mnt -o cachefile=/tmp/zpool.cache tank
cp /tmp/zpool.cache /mnt/boot/zfs

#reboot ;) http://www.youtube.com/watch?v=9HKz77Ka_Xo&feature=related