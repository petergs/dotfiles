#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
source $SCRIPT_DIR/sway-utils.sh

switch_ws(){
    param1=$1
    focusedm=$(get_focused_workspace | cut -c 2)
    focusedws=$(get_focused_workspace | cut -c 1)
    numoutputs=$(count_outputs)

    # do nothing if we're already on the focused workspace set
    # otherwise focus the workspace set
    case $focusedm in
        "p")
            swaymsg workspace "$param1"s, workspace "$param1"p
            ;;
        "s")
            swaymsg workspace "$param1"p, workspace "$param1"s
            ;;
        "")
            # if we're on a 1 character workspace, it should still switch us to
            # a 2 character workspace if there are 2 outputs
            # this also enables dynamically switching to this mode if a new
            # output is added
            if [[ $numoutputs -eq 2 ]]
            then
                swaymsg workspace "$param1"p, workspace "$param1"s
            else
                swaymsg workspace "$param1"
            fi
            ;;
    esac
    # fi
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

