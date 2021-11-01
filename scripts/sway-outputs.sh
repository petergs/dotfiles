#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
source $SCRIPT_DIR/sway-utils.sh

numoutputs=$(count_outputs)

case $(hostname) in
    "bean")
        PRIMARYMON="DisplayPort-0"
        SECONDARYMON="HDMI-A-0"
    ;;

    "lettuce")
        PRIMARYMON="eDP1"
        SECONDARYMON="HDMI1"
    ;;
esac

if [[ $numoutputs = 2 ]]
then
    workspace 1s output $SECONDARYMON
    workspace 1p output $PRIMARYMON
    workspace 2s output $SECONDARYMON
    workspace 2p output $PRIMARYMON
    workspace 3s output $SECONDARYMON
    workspace 3p output $PRIMARYMON
    workspace 4s output $SECONDARYMON
    workspace 4p output $PRIMARYMON
    workspace 5s output $SECONDARYMON
    workspace 5p output $PRIMARYMON
elif [[ $numoutputs = 1 ]]
    workspace 1 output $PRIMARYMON    
    workspace 2 output $PRIMARYMON    
    workspace 3 output $PRIMARYMON    
    workspace 4 output $PRIMARYMON    
    workspace 5 output $PRIMARYMON    
fi

