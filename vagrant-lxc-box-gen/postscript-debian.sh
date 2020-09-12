#!/bin/sh
dpkg-reconfigure openssh-server
rm -rf /var/lib/apt/lists/*
apt-get update
apt-get install -y sudo
rm -rf /var/lib/apt/lists/*
