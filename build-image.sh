#!/bin/bash
docker build -t zestxjest/sawtooth-network-setup:latest .

git clone -b master https://github.com/hyperledger/sawtooth-core --depth=1
cd sawtooth-core/docker
chmod +x ./grafana/grafana_entrypoint.sh
docker build . -f grafana/sawtooth-stats-grafana -t zestxjest/sawtooth-stats-grafana:latest
