get_focused_output() {
    swaymsg -t get_outputs | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2
}

get_focused_workspace() {
    swaymsg -t get_workspaces   | jq '.[] | select(.focused==true).name'   | cut -d"\"" -f2
}

count_outputs() {
    swaymsg -t get_outputs | jq '. | length'
}
