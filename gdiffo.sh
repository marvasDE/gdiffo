#!/bin/bash

gdiffo() {
    if [[ $1 = "" ]] ; then
        git diff
        return 0
    fi

    re='^[0-9]+$'
    diffnames=$(git diff --name-only)

    if [[ $1 =~ $re ]] ; then
        git diff $(echo "$diffnames" | head -$1 | tail +$1)
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
