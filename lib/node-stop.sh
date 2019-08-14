#!/bin/bash
source ./lib/common.sh

function readInputs() {
    getInputWithDefault "Please enter the project name" "sawtooth_node" PROJECT_NAME $GREEN
}

function main() {
    readInputs
    docker-compose -f $PWD/projects/$PROJECT_NAME/docker-compose.yml down
}

main $@
