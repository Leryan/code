#!/bin/sh
csup /root/stable-supfile
cd /usr/src
rm -rf ../obj/*
make kernel
make buildworld
#passage en mode mono utilisateur
mergemaster -pFiU
make installworld
mergemaster -FiU
halt
#make delete-old-libs
