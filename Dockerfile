FROM hyperledger/sawtooth-shell:1.2.1

WORKDIR /sawtooth-network-setup
RUN mkdir -p configs

RUN ls

ENTRYPOINT [ "./setup.sh" ]