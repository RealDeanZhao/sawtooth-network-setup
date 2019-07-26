#!/bin/bash
source ./common.sh

function main() {
    echo -e $YELLOW'Please select an option: \n' \
        $GREEN'1) Setup Metrics \n' \
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
