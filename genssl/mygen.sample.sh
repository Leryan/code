#!/usr/bin/env bash

. ./gen-helpers.sh

export section="dovecot"
export domains="imap.peterschmitt.fr \
    imaps.peterschmitt.fr"
gen_certs

export section="postfix"
export domains="smtp.peterschmitt.fr"
gen_certs

export section="person"
export domain="auth.peterschmitt.fr"
export persons="FlorentPeterschmitt"
gen_ident_certs
