#!/usr/bin/env bash

. ./gen-helpers.sh

#export size="4096"

export section="person"
export domain="beastie.eu"
export persons="FlorentPeterschmitt"
gen_ident_certs
