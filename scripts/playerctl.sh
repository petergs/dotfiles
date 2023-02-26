#!/bin/bash

playerctl metadata -f {{playerName}} 2> /dev/null | grep -Ev 'mopidy' > /dev/null
res="$?"
if [[ $res -eq 0 ]]; then
    echo $(playerctl metadata -f '{{artist}} - {{title}}' 2> /dev/null)
fi
