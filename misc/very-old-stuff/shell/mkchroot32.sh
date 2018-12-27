#!/usr/bin/env sh

mkdir /opt/arch32
sed -e 's/x86\_64/i686/g' /etc/pacman.d/mirrorlist > /opt/arch32/mirrorlist
sed -e 's@/etc/pacman.d/mirrorlist@/opt/arch32/mirrorlist@g' /etc/pacman.conf > /opt/arch32/pacman.conf
mkdir -p /opt/arch32/var/{cache/pacman/pkg, lib/pacman}

pacman --root /opt/arch32 --cachedir /opt/arch32/var/cache/pacman/pkg --config /opt/arch32/pacman.conf -Syy
pacman --root /opt/arch32 --cachedir /opt/arch32/var/cache/pacman/pkg --config /opt/arch32/pacman.conf -S base base-devel
