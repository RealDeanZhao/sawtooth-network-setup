#!/bin/bash
source ./common.sh

function main() {
    flagmain=true
    echo -e $YELLOW'Please select an option: \n' \
        $GREEN'1) Create Basic Node \n' \
        $PINK'2) Create Genesis Batch \n' \
        $BLUE'3) Start Node \n' \
        $RED'4) Exit'

    printf $WHITE'option: '$COLOR_END

    read option

    case $option in
    1)
        docker run -it -v ${PWD}:/sawtooth-network-setup zestxjest/sawtooth-network-setup:latest ./node.sh $@
        ;;
    2)
        docker run -it -v ${PWD}:/sawtooth-network-setup zestxjest/sawtooth-network-setup:latest ./genesis.sh $@
        ;;
    3)
        ./node-start.sh $@
        ;;
    3)
        flagmain=false
        ;;
    esac

}

main $@
