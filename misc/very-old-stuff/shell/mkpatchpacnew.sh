#!/usr/bin/env sh

pacnew=`find /etc -name "*.pacnew" 2> /dev/null`

for p in $pacnew; do
    pp=`echo $p | sed 's/.pacnew//g'`
    diff -u $pp $p >> patch
done

