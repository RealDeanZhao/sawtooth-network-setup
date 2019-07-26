#!/bin/bash
source ./common.sh

function readInputs() {
    getInputWithDefault "Please enter the influxdb volume name" "sawtooth-stats-influxdb" SAWTOOTH_STATS_INFLUXDB_VOLUME $GREEN
    getInputWithDefault "Please enter the influxdb pore" 8086 SAWTOOTH_STATS_INFLUXDB_PORT $GREEN
    getInputWithDefault "Please enter the influxdb admin password" "adminpw" SAWTOOTH_STATS_INFLUXDB_ADMIN_PASSWORD $GREEN
    getInputWithDefault "Please enter the influxdb user password" "lrdatapw" SAWTOOTH_STATS_INFLUXDB_USER_PASSWORD $GREEN
    getInputWithDefault "Please enter the grafana port" 3000 SAWTOOTH_STATS_GRAFANA_PORT $GREEN
}

function runInfluxDb() {
    docker volume create $SAWTOOTH_STATS_INFLUXDB_VOLUME
    docker container rm -f sawtooth-stats-influxdb
    docker run -d -p $SAWTOOTH_STATS_INFLUXDB_PORT:8086 -v $SAWTOOTH_STATS_INFLUXDB_VOLUME:/var/lib/influxdb \
        -e INFLUXDB_DB=metrics -e INFLUXDB_HTTP_AUTH_ENABLED=true \
        -e INFLUXDB_ADMIN_USER=admin -e INFLUXDB_ADMIN_PASSWORD=$SAWTOOTH_STATS_INFLUXDB_ADMIN_PASSWORD \
        -e INFLUXDB_USER=lrdata -e INFLUXDB_USER_PASSWORD=$SAWTOOTH_STATS_INFLUXDB_USER_PASSWORD \
        --name sawtooth-stats-influxdb influxdb
}

function runGrafana() {
    echo $SAWTOOTH_STATS_GRAFANA_PORT
    docker container rm -f sawtooth-stats-grafana
    docker run -d -p $SAWTOOTH_STATS_GRAFANA_PORT:3000 --name sawtooth-stats-grafana \
        zestxjest/sawtooth-stats-grafana
}
function main() {
    readInputs
    runInfluxDb
    runGrafana
}

main $@
