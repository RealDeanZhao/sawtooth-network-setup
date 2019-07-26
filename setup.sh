#!/bin/bash
source ./common.sh

function main() {

    flagmain=true
    echo -e $YELLOW'Please select an option: \n' \
        $GREEN'1) Create Basic Node \n' \
        $PINK'2) Create Genesis Batch \n' \
        $RED'3) Exit'

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
        flagmain=false
        ;;
    esac

}

main $@
