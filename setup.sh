#!/bin/bash
source ./common.sh

function main() {

    flagmain=true
    echo -e $YELLOW'Please select an option: \n' \
        $GREEN'1) Create Network \n' \
        $PINK'2) Join Network \n' \
        $RED'3) Exit'

    printf $WHITE'option: '$COLOR_END

    read option

    case $option in
    1)
        ./create_network.sh $@
        ;;
    2)
        ./join_network.sh $@
        ;;
    3)
        flagmain=false
        ;;
    esac

}

main $@
