#!/bin/bash

gdiffo() {
    if [[ $1 = "" ]] ; then
        git diff
        return 0
    fi

    one_number_pattern='^[0-9]+$'
    diffnames=$(git diff --name-only)

    if [[ $1 =~ $one_number_pattern ]] ; then
        git diff $(echo "$diffnames" | head -$1 | tail +$1)
        return 0
    fi

    multiple_numbers_pattern='^[0-9]([0-9]|,|-)+[0-9]$'
    if [[ $1 =~ $multiple_numbers_pattern ]] ; then
        awknumbers=$(echo $1 | sed -E 's/([0-9]+)-([0-9]+)/\NR>=\1 \&\& NR<=\2/g')
        awknumbers=$(echo $awknumbers | sed -E 's/(^|,)([0-9]+)/\1NR == \2/g')
        awknumbers=$(echo $awknumbers | sed -E 's/,/ || /g')

        git diff $(echo "$diffnames" | awk "$awknumbers")
        return 0
    fi

    diffresult=$(echo "$diffnames" | grep -i $1)
    if [[ $diffresult = "" ]] ; then
        RED='\033[0;31m'
        NC='\033[0m' # No Color
	    echo -e "parameter ${RED}$1${NC} does not match any file"
        return 0
    fi
    
    git diff $diffresult
    return 0
}

gdiffo $1
