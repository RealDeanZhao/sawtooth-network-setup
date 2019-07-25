#!/bin/bash
source ./common.sh

function generateGenesisBatch() {
    echo "Generate user key"
    sawtooth keygen my_key
    printf "User public key: %b\n" $(cat ~/.sawtooth/keys/my_key.pub)

    echo "Generate validator key"
    sawadm keygen
    printf "Validator public key: %b\n" $(cat /etc/sawtooth/keys/validator.pub)

    echo "Generate genesis config"
    cd /tmp
    sawset genesis --key ~/.sawtooth/keys/my_key.priv -o config-genesis.batch

    echo "Initialize consensus settings "
    #echo \'[\"$(cat /etc/sawtooth/keys/validator.pub)\"]\'
    sawset proposal create --key ~/.sawtooth/keys/my_key.priv -o config-consensus.batch \
        sawtooth.consensus.algorithm.name=pbft \
        sawtooth.consensus.algorithm.version=1.0 \
        sawtooth.consensus.pbft.members=\'[\"$(cat /etc/sawtooth/keys/validator.pub)\"]\'

    echo "Generating genesis.batch"
    sawadm genesis config-genesis.batch config-consensus.batch
}

function readInputs() {
    getInputWithDefault "Please enter the bind_network" "tcp://0.0.0.0:8800" VALIDATOR_CONFIG_BIND_NETWORK $GREEN
    getInputWithDefault "Please enter the bind_compoenent" "tcp://0.0.0.0:4004" VALIDATOR_CONFIG_BIND_COMPONENT $GREEN
    getInputWithDefault "Please enter the bind_consensus" "tcp://0.0.0.0:5050" VALIDATOR_CONFIG_BIND_CONSENSUS $GREEN
    getInputWithDefault "Please enter the endpoint" "tcp://0.0.0.0:8800" VALIDATOR_CONFIG_ENDPOINT $GREEN
    getInputWithDefault "Please enter the peers" "\"tcp://127.0.0.1:8800\"" VALIDATOR_CONFIG_PEERS $GREEN
}

function sedFile() {
    sed -i $1 $2
}

function generateValadatorNetworkKeyPair() {
    python3 /sawtooth-network-setup/network_key_pair.py >/tmp/network_key_pair.txt
    #cat /tmp/network_key_pair.txt
    VALIDATOR_CONFIG_NETWORK_PUBLIC_KEY=$(sed '1q;d' /tmp/network_key_pair.txt)
    VALIDATOR_CONFIG_NETWORK_PRIVATE_KEY=$(sed '2q;d' /tmp/network_key_pair.txt)
    rm /tmp/network_key_pair.txt
}

function copyThings() {
    mkdir -p /sawtooth-network-setup/data/lib
    mkdir -p /sawtooth-network-setup/data/etc
    mkdir -p /sawtooth-network-setup/data/home
    cp -r /var/lib/sawtooth /sawtooth-network-setup/data/lib
    cp -r /etc/sawtooth /sawtooth-network-setup/data/etc
    cp -r ~/.sawtooth /sawtooth-network-setup/data/home
}
function initValidatorConfig() {
    generateValadatorNetworkKeyPair
    validatorConfigTemplate="$(cat /sawtooth-network-setup/validator.toml.template)"
    eval "echo \"$validatorConfigTemplate\"" >/etc/sawtooth/validator.toml
}

function generateComposeFile() {
    composeTemplate="$(cat /sawtooth-network-setup/docker-compose.yml.template)"
    eval "echo \"$composeTemplate\"" >/sawtooth-network-setup/docker-compose.yml
}

function main() {
    generateGenesisBatch
    readInputs
    initValidatorConfig
    copyThings
    generateComposeFile
}

main $@
