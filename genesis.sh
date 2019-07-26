#!/bin/bash
source ./common.sh

function readInputs() {
    getInputWithDefault "Please enter the pbft_member_list" [""] PBFT_MEMBER_LIST $GREEN
}

function generateGenesisBatch() {
    generateKeys

    echo "Generate genesis config"
    cd /tmp
    sawset genesis --key ~/.sawtooth/keys/my_key.priv -o config-genesis.batch

    echo "Initialize consensus settings "
    sawset proposal create --key ~/.sawtooth/keys/my_key.priv -o config-consensus.batch \
        sawtooth.consensus.algorithm.name=pbft \
        sawtooth.consensus.algorithm.version=1.0 \
        sawtooth.consensus.pbft.members=$PBFT_MEMBER_LIST

    echo "Generating genesis.batch"
    sawadm genesis config-genesis.batch config-consensus.batch
}

function copyThings() {
    mkdir -p /sawtooth-network-setup/data/lib
    cp -r /var/lib/sawtooth /sawtooth-network-setup/data/lib
}

function main() {
    readInputs
    copyThings
}

main $@
