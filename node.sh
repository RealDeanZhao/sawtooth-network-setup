#!/bin/bash
source ./common.sh

function readInputs() {
    getInputWithDefault "Please enter the node_name" "sawtooth_node" SAWTOOH_NODE_NAME $GREEN
    getInputWithDefault "Please enter the endpoint" "tcp://0.0.0.0" VALIDATOR_CONFIG_ENDPOINT $GREEN
    getInputWithDefault "Please enter the endpoint port" "8800" VALIDATOR_CONFIG_ENDPOINT_PORT $GREEN
    getInputWithDefault "Please enter the peers" "\"\"" VALIDATOR_CONFIG_PEERS $GREEN
    getInputWithDefault "Please enter the rest api port" "8008" REST_API_CONFIG_PORT $GREEN
}

function generateValadatorNetworkKeyPair() {
    python3 /sawtooth-network-setup/network_key_pair.py >/tmp/network_key_pair.txt
    #cat /tmp/network_key_pair.txt
    VALIDATOR_CONFIG_NETWORK_PUBLIC_KEY=$(sed '1q;d' /tmp/network_key_pair.txt)
    VALIDATOR_CONFIG_NETWORK_PRIVATE_KEY=$(sed '2q;d' /tmp/network_key_pair.txt)
    rm /tmp/network_key_pair.txt
}

function copyThings() {
    mkdir -p /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/lib
    mkdir -p /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/etc
    mkdir -p /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/home
    cp -r /var/lib/sawtooth /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/lib
    cp -r /etc/sawtooth /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/etc
    cp -r ~/.sawtooth /sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/home
}

function initValidatorConfig() {
    generateValadatorNetworkKeyPair
    validatorConfigTemplate="$(cat /sawtooth-network-setup/validator.toml.template)"
    eval "echo \"$validatorConfigTemplate\"" >/etc/sawtooth/validator.toml
}

function generateComposeFile() {
    composeTemplate="$(cat /sawtooth-network-setup/docker-compose.yml.template)"
    eval "echo \"$composeTemplate\"" >/sawtooth-network-setup/nodes/$SAWTOOH_NODE_NAME/docker-compose.yml
}

function main() {
    generateKeys
    readInputs
    initValidatorConfig
    copyThings
    generateComposeFile
}

main $@
