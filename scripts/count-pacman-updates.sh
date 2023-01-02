#!/bin/bash

# icons 

checkupdates 1> /tmp/checkupdates.out
res="$?"
if [ $res -eq 2 ]; then
    echo 0
elif [ $res -eq 1 ]; then
    echo "?" 
else
    wc -l /tmp/checkupdates.out | awk '{print $1}' 
fi
