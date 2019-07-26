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
    runSawtoothShellCmd sawtooth keygen my_key
    printf "User public key: %b\n" $(cat $PWD/projects/$PROJECT_NAME/home/keys/my_key.pub)

    echo "Generate validator key"
    runSawtoothShellCmd sawadm keygen
    printf "Validator public key: %b\n" $(cat $PWD/projects/$PROJECT_NAME/etc/keys/validator.pub)
}

function runSawtoothShellCmd() {
    docker rm -f tmp-sawtooth-shell-cmd
    # must create the folder here, or the validator key will not be generated
    mkdir -p $PWD/projects/$PROJECT_NAME/etc/keys
    docker run \
        -v $PWD/projects/$PROJECT_NAME/etc:/etc/sawtooth \
        -v $PWD/projects/$PROJECT_NAME/lib:/var/lib/sawtooth \
        -v $PWD/projects/$PROJECT_NAME/home:/root/.sawtooth \
        --name tmp-sawtooth-shell-cmd \
        hyperledger/sawtooth-shell:chime $@
    docker rm -f tmp-sawtooth-shell-cmd
}
