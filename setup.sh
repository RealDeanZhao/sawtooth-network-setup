#!/bin/bash
source ./common.sh

function main() {
    echo -e $YELLOW'Please select an option: \n' \
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
    1)
        ./node.sh $@
        ;;
    2)
        ./genesis.sh $@
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
    l)
        ./node-log.sh $@
        ;;
    x)
        ./tools.sh $@
        ;;
    0) echo "Bye" ;;

    esac

}

main $@
