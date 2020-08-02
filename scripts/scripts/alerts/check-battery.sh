#!/bin/bash

# get current battery charge level
battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)
if [ $battery_capacity -le 5 ] && [ $battery_status != "Charging" ]
then
    # take screenshot
    scrot /tmp/screen.png
    
    # apply a transformation
    # uncomment the desired value
    convert /tmp/screen.png -blur 0x8 /tmp/edited_screen.png
    # convert /tmp/screen.png -fill black -colorize 90% /tmp/edited_screen.png 

    # temporarily change border highlight color
    normal_border=$(bspc config normal_border_color)
    focused_border=$(bspc config focused_border_color)  
    bspc config focused_border_color $normal_border

    # run python script passing resolution and the background image
    python3 /home/ppop/.dotfiles/scripts/scripts/alerts/battery.py

    # return focused border color to original 
    bspc config focused_border_color $focused_border
fi

