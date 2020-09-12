#!/usr/bin/env bash

if [ ! -e serial ]; then
    echo -n '01' > serial
fi

if [ ! -d ./ca/\{keys,certs\} ]; then
    mkdir -p ./ca/{keys,certs}
fi

if [ ! -e values.sh ]; then
    cat values.sample.sh > values.sh
    chmod +x values.sh
fi

. ./values.sh

if [ "$ca_protect" = "no" ]; then
    ca_extra_opts="${ca_extra_opts} -nodes"
fi

if [ ! -f "ca/keys/${ca_name}.ca.key" ]; then
    openssl req -new -x509 -keyout "ca/keys/${ca_name}.ca.key" -keyform ${format} \
        -out "ca/certs/${ca_name}.ca.crt" -outform ${format} \
        -days $ca_days -newkey rsa:$ca_size \
        -config ${config} \
        -subj "${ca_subj}" ${ca_extra_opts} || exit 1
else
    echo "ALREADY EXISTS (${ca_name})" 1>&2
fi
