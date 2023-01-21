#!/bin/bash

# icons 

checkupdates > /tmp/checkupdates.out 2>&1
res="$?"
if [ $res -eq 2 ]; then
    echo 0
elif [ $res -eq 1 ]; then
    echo "?" 
else
    wc -l /tmp/checkupdates.out | awk '{print $1}' 
fi
