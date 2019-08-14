#!/bin/bash
source ./lib/common.sh

function readInputs() {
    getInputWithDefault "Please input the project name" "sawtooth-stats" SAWTOOTH_STATS_PROJECT_NAME $GREEN
    getInputWithDefault "Please enter the influxdb volume name" "sawtooth-stats-influxdb" SAWTOOTH_STATS_INFLUXDB_VOLUME $GREEN
    getInputWithDefault "Please enter the influxdb pore" 8086 SAWTOOTH_STATS_INFLUXDB_PORT $GREEN
    getInputWithDefault "Please enter the influxdb admin password" "adminpw" SAWTOOTH_STATS_INFLUXDB_ADMIN_PASSWORD $GREEN
    getInputWithDefault "Please enter the influxdb user password" "lrdatapw" SAWTOOTH_STATS_INFLUXDB_USER_PASSWORD $GREEN
    getInputWithDefault "Please enter the grafana port" 3000 SAWTOOTH_STATS_GRAFANA_PORT $GREEN
}

function generateComposeFile() {
    composeTemplate="$(cat ./tmpl/docker-compose-metrics.yml.template)"
    mkdir -p ./nodes/$SAWTOOTH_STATS_PROJECT_NAME
    eval "echo \"$composeTemplate\"" >./nodes/$SAWTOOTH_STATS_PROJECT_NAME/docker-compose.yml
}

function runCompose() {
    docker-compose -f ./nodes/$SAWTOOTH_STATS_PROJECT_NAME/docker-compose.yml up -d
}

function main() {
    readInputs
    generateComposeFile
    runCompose
}

main $@
