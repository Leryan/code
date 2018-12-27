#!/usr/bin/env sh

while true; do
    flash=`ps -ef | grep "flashplayer" | awk '$8 !~ /^grep/ && $3 ~ /^1$/ {print $2}'`

    if [[ $flash != "" ]]; then
        kill -s 9 `echo $flash`
    fi

    sleep 5
done
