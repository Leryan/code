#!/usr/bin/env bash

if [ ! -z "${1}" ]; then
    name="${1}"
fi

if [ ! -d ./\{keys,certs,csr,p12\} ]; then
    mkdir -p ./{keys,certs,csr,p12}
fi

if [ ! -e values.sh ]; then
    cat values.sample.sh > values.sh
    chmod +x values.sh
fi

. ./values.sh

if [ ! -z "${sign_keys}" ]; then
    if [ ! -e ca/certs/${ca_name}.ca.crt ]||[ ! -e ca/keys/${ca_name}.ca.key ]; then
        echo "Generate the CA first." 1>&2
        exit 1
    fi
fi

if [ "$protect" = "no" ]; then
    extra_opts="${extra_opts} -nodes"
fi

if [ ! -f "keys/${name}.key" ]; then
    echo "GENERATE ${name}" 1>&2
    openssl req -new -keyform ${format} -keyout "keys/${name}.key" \
        -outform ${format} -out "csr/${name}.csr" -nodes \
        -config ${config} \
        -newkey rsa:${size} -subj "${subj}" ${extra_opts} || exit 1
else
    echo "ALREADY EXISTS (${name})" 1>&2
fi

if [ ! -z "$sign_keys" ]; then
    echo "SIGNING with ${ca_name}" 1>&2
    openssl x509 -CA "ca/certs/${ca_name}.ca.crt" -CAkey "ca/keys/${ca_name}.ca.key" \
        -CAserial serial -req -in "csr/${name}.csr" \
        -outform PEM -out "certs/${name}.crt" -days $days ${sign_opts} || exit 1
else
    echo "AUTOSIGN ${name}" 1>&2
    openssl x509 -signkey "keys/${name}.key" -req -in "csr/${name}.csr" \
        -outform PEM -out "certs/${name}.crt" -days $days ${sign_opts} || exit 1
fi

