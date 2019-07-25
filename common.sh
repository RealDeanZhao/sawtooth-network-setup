#!/bin/bash
RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
BLUE=$'\e[1;34m'
PINK=$'\e[1;35m'
CYAN=$'\e[1;96m'
WHITE=$'\e[1;39m'
COLOR_END=$'\e[0m'

function getInputWithDefault() {
    local msg=$1
    local __defaultValue=$2
    local __resultvar=$3
    local __clr=$4

    if [ -z "$__clr" ]; then

        __clr=$RED

    fi

    if [ -z "$__defaultValue" ]; then

        read -p $__clr"$msg: "$COLOR_END __newValue
    else
        read -p $__clr"$msg""[Default:"$__defaultValue"]:"$COLOR_END __newValue
    fi

    if [ -z "$__newValue" ]; then

        __newValue=$__defaultValue

    fi

    eval $__resultvar="'$__newValue'"
}

function generateKeys() {
    echo "Generate user key"
    sawtooth keygen my_key
    printf "User public key: %b\n" $(cat ~/.sawtooth/keys/my_key.pub)

    echo "Generate validator key"
    sawadm keygen
    printf "Validator public key: %b\n" $(cat /etc/sawtooth/keys/validator.pub)
}
