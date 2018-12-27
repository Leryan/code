#!/usr/bin/env bash

confs=$(ls confs)
i=0

for e in $confs
do
    choices[$i]=$e
    echo "$i : $e"
    i=$( echo "$i+1" | bc)
done

echo -n "Faites votre choix : "
read choice

openvpn confs/${choices[$choice]}
