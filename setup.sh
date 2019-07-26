#!/bin/bash
source ./common.sh

function main() {
    echo -e $YELLOW'Please select an option: \n' \
        $GREEN'1) Create Basic Node \n' \
        $PINK'2) Create Genesis Batch \n' \
        $BLUE'3) Start Node \n' \
        $YELLOW'4) Stop Node \n' \
        $PINK'5) Restart Node \n' \
        $CYAN'6) Log \n' \
        $WHITE'7) Other Tools \n' \
        $RED'0) Exit'

    printf $WHITE'option: '$COLOR_END

    read option

    case $option in
    1)
        docker run -it --name sawtooth-network-setup -v ${PWD}:/sawtooth-network-setup zestxjest/sawtooth-network-setup:latest ./node.sh $@
        docker rm -f sawtooth-network-setup
        ;;
    2)
        docker run -it --name sawtooth-network-setup -v ${PWD}:/sawtooth-network-setup zestxjest/sawtooth-network-setup:latest ./genesis.sh $@
        docker rm -f sawtooth-network-setup
        ;;
    3)
        ./node-start.sh $@
        ;;
    4)
        ./node-stop.sh $@
        ;;
    5)
        ./node-restart.sh $@
        ;;
    6)
        ./node-log.sh $@
        ;;
    7)
        ./tools.sh $@
        ;;
    0) echo "Bye" ;;

    esac

}

main $@
