#!/bin/bash
source ./common.sh

function main() {
    echo -e $YELLOW'Please select an option: \n' \
        $BLUE'0) Install Dependencies \n' \
        $GREEN'1) Create Sawtooth Node \n' \
        $PINK'2) Create Genesis Batch \n' \
        $BLUE'3) Start Project \n' \
        $YELLOW'4) Stop Project \n' \
        $CYAN'5) Restart Project \n' \
        $PINK'l) Log \n' \
        $WHITE'x) Other Tools \n' \
        $RED'0) Exit'

    printf $WHITE'option: '$COLOR_END

    read option

    case $option in
    0)
        ./lib/dependency.sh $@
        ;;
    1)
        ./lib/node.sh $@
        ;;
    2)
        ./lib/genesis.sh $@
        ;;
    3)
        ./lib/node-start.sh $@
        ;;
    4)
        ./lib/node-stop.sh $@
        ;;
    5)
        ./lib/node-restart.sh $@
        ;;
    l)
        ./lib/node-log.sh $@
        ;;
    x)
        ./lib/tools.sh $@
        ;;
    0) echo "Bye" ;;

    esac

}

main $@
