#!/usr/bin/env sh
IsCo=`ping google.fr -c 3 2>&1 | grep "received" | sed -e 's/.*\([0-3].* received\).*/\1/' -e 's/[a-z_ ]//g'`

if [[ $IsCo == "" ]]
then
    ifconfig eth0 up
    RecordLog="eth0 re-up"
elif [[ $IsCo == "3" ]]
then
    RecordLog="eth0 up"
else
    RecordLog="There is a problem with your connection"
fi

if (( $# > 0 )) && [[ $1 == "log-all" ]]
then
    echo `date +"[%Y:%m:%d %k:%M:%S]"` $RecordLog >> log-cn.sh.log
fi
    
