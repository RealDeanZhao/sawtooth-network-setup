#!/bin/bash
source ./common.sh

function readInputs() {
    getInputWithDefault "Please enter the node_name" "sawtooth_node" SAWTOOH_NODE_NAME $GREEN
    getInputWithDefault "Please enter the pbft_member_list" [""] PBFT_MEMBER_LIST $GREEN
}

function generateGenesisBatch() {
    echo "Generate genesis config"
    cd /tmp
    MY_KEY_FILE=/sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/home/.sawtooth/keys/my_key.priv
    sawset genesis --key $MY_KEY_FILE -o config-genesis.batch

    echo "Initialize consensus settings "
    sawset proposal create --key $MY_KEY_FILE -o config-consensus.batch \
        sawtooth.consensus.algorithm.name=pbft \
        sawtooth.consensus.algorithm.version=1.0 \
        sawtooth.consensus.pbft.members=$PBFT_MEMBER_LIST

    echo "Generating genesis.batch"
    sawadm genesis config-genesis.batch config-consensus.batch
}

function copyThings() {
    mkdir -p /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/lib
    cp -r /var/lib/sawtooth /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/lib
}

function main() {
    readInputs
    generateGenesisBatch
    copyThings
}

main $@
