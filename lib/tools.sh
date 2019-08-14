#!/bin/bash
source ./lib/common.sh

function main() {
    echo -e $YELLOW'Please select an option: \n' \
        $GREEN'1) Setup Metrics \n' \
        $PINK'2) Setup Sawtooth Explorer \n' \
        $RED'0) Exit'

    printf $WHITE'option: '$COLOR_END

    read option

    case $option in
    1)
        ./metrics.sh $@
        ;;
    0) echo "Bye" ;;

    esac
}

main $@
