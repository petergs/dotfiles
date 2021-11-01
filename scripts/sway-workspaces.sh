#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
source $SCRIPT_DIR/sway-utils.sh

switch_ws(){
    param1=$1
    focusedm=$(get_focused_workspace | cut -c 2)
    focusedws=$(get_focused_workspace | cut -c 1)

    # do nothing if we're already on the focused workspace set
    # otherwise focus the workspace set
    if [[ $focusedws != $param1 ]]
    then
        case $focusedm in
            "p")
                swaymsg workspace "$param1"s, workspace "$param1"p
                ;;
            "s")
                swaymsg workspace "$param1"s, workspace "$param1"s
                ;;
            "")
                swaymsg workspace "$param1"
                ;;
        esac
    fi
}

move_win() {
    param1=$1
    # will be empty if there is only 1 output
    focusedm=$(get_focused_workspace | cut -c 2)
    swaymsg move container to workspace "$param1""$focusedm" 
}

case "$1" in
    "")
        echo "Please supply at least one argument" 
        exit 1
        ;;
    "switch")
        switch_ws $2
        ;; 
    "move")
        move_win $2 
        ;;
esac

