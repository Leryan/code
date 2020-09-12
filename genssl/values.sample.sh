#!/usr/bin/env bash

####
##
## If you want to override any of these parameters, simply export it before in
## your shell, or copy `values.sample.sh` to `values.sh` and modify these values
## before executing any script.
##
####

##
# ca_ prefixed vars are for Certificate Authority, other are for simple certs/keys.
# sign_keys should be empty if you want self-signed certificates
##
export ca_size=${ca_size:-8192}
export size=${size:-8192}
export sign_keys="YES" # just export sign_keys=    if you dont want to sign with CA
export format=${format:-"PEM"}


####
##
## Generate Certificate Authority's parameters.
##
####

###
# Used to build CA's subject.
###
ca_country_code=${ca_country_code:-"FR"}
ca_state=${ca_state:-"France"}
ca_locality=${ca_locality:-"Lille"}
ca_org=${ca_org:-"Florent Peterschmitt"}
ca_org_unit=${ca_org_unit:-"Florent Peterschmitt"}
ca_common_name=${ca_common_name:-"Florent Peterschmitt"}
ca_email=${ca_email:-"florent@peterschmitt.fr"}

export ca_extra_opts=${ca_extra_opts:-""}
export ca_protect=${ca_protect:-"no"} # Shortcut for -nodes openssl option.
export ca_name=${ca_name:-"FlorentPeterschmitt"} # Will be used for certificate and key filename.
export ca_days=${ca_days:-730}
export ca_subj=${ca_subj:-"/C=${ca_country_code}/ST=${ca_state}/L=${ca_locality}/O=${ca_org}/OU=${ca_org_unit}/CN=${ca_common_name}/emailAddress=${ca_email}"}

####
##
## Generate certificate parameters.
##
####

##
# Used to build subject.
##
country_code=${country_code:-"FR"}
state=${state:-"France"}
locality=${locality:-"Lille"}
org=${org:-"Florent Peterschmitt"}
org_unit=${org_unit:-"Florent Peterschmitt"}
common_name=${common_name:-"localhost"} # FQDN for example.
email=${email:-"florent@peterschmitt.fr"}

export config=${config:-"openssl.cnf"}
export extra_opts=${extra_opts:-""}
export sign_opts=${sign_opts:-""}
export protect=${protect:-"no"} # Shortcut for -nodes openssl option.
export name=${name:-"default-ssl"}
export days=${days:-365}
export subj=${subj:-"/C=${country_code}/ST=${state}/L=${locality}/O=${org}/OU=${org_unit}/CN=${common_name}/emailAddress=${email}"}
