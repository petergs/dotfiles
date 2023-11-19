#!/bin/bash

# return the name of the focused input
get_focused_output() {
    swaymsg -t get_outputs | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2
}

# return name of the focused workspace
get_focused_workspace() {
    swaymsg -t get_workspaces   | jq '.[] | select(.focused==true).name'   | cut -d"\"" -f2
}

# return the number of outputs in sway
count_outputs() {
    swaymsg -t get_outputs | jq '. | length'
}

# return a json array of outputs
# each element is an object like { name, active }
get_output_names() {
    swaymsg -t get_outputs | jq '[.[] | {name: .name, active: .active}]'
}
