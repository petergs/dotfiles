#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
source $SCRIPT_DIR/sway-utils.sh

numoutputs=$(count_outputs)

case $(hostname) in
    "bean")
        PRIMARYMON="DP-1"
        SECONDARYMON="HDMI-A-1"
    ;;

    "lettuce")
        PRIMARYMON="eDP1"
        SECONDARYMON="HDMI1"
    ;;
esac

if [[ $numoutputs = 2 ]]
then
    swaymsg workspace 1s output $SECONDARYMON
    swaymsg workspace 1p output $PRIMARYMON
    swaymsg workspace 2s output $SECONDARYMON
    swaymsg workspace 2p output $PRIMARYMON
    swaymsg workspace 3s output $SECONDARYMON
    swaymsg workspace 3p output $PRIMARYMON
    swaymsg workspace 4s output $SECONDARYMON
    swaymsg workspace 4p output $PRIMARYMON
    swaymsg workspace 5s output $SECONDARYMON
    swaymsg workspace 5p output $PRIMARYMON
    # switch immediately to 2 char naming scheme
    swaymsg workspace 1s, workspace 1p
elif [[ $numoutputs = 1 ]]
then
    swaymsg workspace 1 output $PRIMARYMON    
    swaymsg workspace 2 output $PRIMARYMON    
    swaymsg workspace 3 output $PRIMARYMON    
    swaymsg workspace 4 output $PRIMARYMON    
    swaymsg workspace 5 output $PRIMARYMON    
fi

