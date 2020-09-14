#!/usr/bin/env sh

while true;
    do
        sleep 0.75
        cat /proc/cpuinfo | grep "cpu MHz" | sed s/[^0-9\.]//g
done
