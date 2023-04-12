#!/bin/bash

out=$(ip -4 addr show "$1" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n1)
if [[ $out = '' ]]; then 
    echo 'disconnected'
else 
    echo "$out"
fi
