#!/bin/bash
source ./common.sh

function readInputs() {
    getInputWithDefault "Please enter the endpoint" "tcp://0.0.0.0" VALIDATOR_CONFIG_ENDPOINT $GREEN
    getInputWithDefault "Please enter the endpoint port" "8800" VALIDATOR_CONFIG_ENDPOINT_PORT $GREEN
    getInputWithDefault "Please enter the peers" "\"\"" VALIDATOR_CONFIG_PEERS $GREEN
    getInputWithDefault "Please enter the rest api port" "8008" REST_API_CONFIG_PORT $GREEN
    getInputWithDefault "Please enter the influx url" "http://127.0.0.1:8086" OPENTSDB_CONFIG_URL $GREEN
    getInputWithDefault "Please enter the influx db" "metrics" OPENTSDB_CONFIG_DB $GREEN
    getInputWithDefault "Please enter the influx user" "lrdata" OPENTSDB_CONFIG_USER $GREEN
    getInputWithDefault "Please enter the influx password" "lrdatapw" OPENTSDB_CONFIG_PWD $GREEN
}

function generateValadatorNetworkKeyPair() {
    echo $YELLOW"Please enter the exsisting network key pair or copy/paste the random value below:"
    echo $RED"=========Same sawtooth network should use same key pair======================="
    python3 ./network_key_pair.py
    echo $RED"=============================================================================="
    getInputWithDefault "Please enter the network public key" "" VALIDATOR_CONFIG_NETWORK_PUBLIC_KEY $GREEN
    getInputWithDefault "Please enter the network private key" "" VALIDATOR_CONFIG_NETWORK_PRIVATE_KEY $GREEN
}

function initValidatorConfig() {
    generateValadatorNetworkKeyPair
    validatorConfigTemplate="$(cat $PWD/validator.toml.template)"
    eval "echo \"$validatorConfigTemplate\"" >./projects/$PROJECT_NAME/etc/validator.toml
}

function generateComposeFile() {
    composeTemplate="$(cat $PWD/docker-compose.yml.template)"
    eval "echo \"$composeTemplate\"" >./projects/$PROJECT_NAME/docker-compose.yml
}

function main() {
    getInputWithDefault "Please enter the project name" "sawtooth_node" PROJECT_NAME $GREEN
    generateKeys
    readInputs
    initValidatorConfig
    generateComposeFile
}

main $@
