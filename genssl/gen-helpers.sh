#!/usr/bin/env bash

gen_certs() {
    for domain in ${domains}; do
        export common_name="${domain}"
        export name="${section}-${common_name}"
        ./gen-keys.sh || exit 1
    done
}

gen_ident_certs() {
    export extra_opts="${extra_opts} -extensions clientauth"
    for person in ${persons}; do
        person_name=$(echo $person | cut -d: -f1)
        person_protect=$(echo $person | cut -d: -f2)
        export common_name="${person_name} at ${domain}"
        export name="${section}-${person_name}"
        ./gen-keys.sh || exit 1
        . ./values.sh
        if [ "${person_protect}" = "protect" ]; then
            person_protect=$(dd if=/dev/urandom bs=4096 count=1 2> /dev/null| md5sum | awk '{print $1}')
            echo $person_protect > keys/${name}.key.password
        else
            person_protect=""
        fi
        openssl pkcs12 -export -out p12/${name}.p12 \
            -inkey keys/${name}.key \
            -in certs/${name}.crt \
            -certfile ca/certs/${ca_name}.ca.crt \
            -password pass:"${person_protect}" || exit 1
    done
}
