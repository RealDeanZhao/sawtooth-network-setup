#!/bin/bash
source ./lib/common.sh

function readInputs() {
    getInputWithDefault "Please enter the project name" "sawtooth_node" PROJECT_NAME $GREEN
    getInputWithDefault "Please enter the pbft_member_list" [""] PBFT_MEMBER_LIST $GREEN
}

function generateGenesisBatch() {
    echo "Generate genesis config"
    MY_KEY_FILE=/root/.sawtooth/keys/my_key.priv

    docker run --rm \
        -v $PWD/projects/$PROJECT_NAME/etc:/etc/sawtooth \
        -v $PWD/projects/$PROJECT_NAME/lib:/var/lib/sawtooth \
        -v $PWD/projects/$PROJECT_NAME/home:/root/.sawtooth \
        --name tmp-sawtooth-shell-cmd \
        hyperledger/sawtooth-shell:chime /bin/bash -c \
        "sawset genesis --key $MY_KEY_FILE -o config-genesis.batch
        echo \"Initialize consensus settings\"
        sawset proposal create --key $MY_KEY_FILE -o config-consensus.batch \\
            sawtooth.consensus.algorithm.name=pbft \\
            sawtooth.consensus.algorithm.version=1.0 \\
            sawtooth.consensus.pbft.members=$PBFT_MEMBER_LIST

        echo \"Generating genesis.batch\"
        sawadm genesis config-genesis.batch config-consensus.batch"
}

function copyThings() {
    mkdir -p /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/lib
    cp -r /var/lib/sawtooth /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/lib
}

function main() {
    readInputs
    generateGenesisBatch
}

main $@
