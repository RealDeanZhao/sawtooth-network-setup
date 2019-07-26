#!/bin/bash
source ./common.sh

function readInputs() {
    getInputWithDefault "Please enter the node_name" "sawtooth_node" SAWTOOH_NODE_NAME $GREEN
}

function main() {
    readInputs
    docker-compose -f $PWD/nodes/$SAWTOOH_NODE_NAME/docker-compose.yml logs -f
}

main $@
