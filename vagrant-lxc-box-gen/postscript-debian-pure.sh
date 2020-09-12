#!/bin/sh
rm -rf /var/lib/apt/lists/*
apt-get update
apt-get install -y strace vim htop dnsutils tcpdump tmux curl bzip2 rsyslog less rsync file tree
rm -rf /var/lib/apt/lists/*
