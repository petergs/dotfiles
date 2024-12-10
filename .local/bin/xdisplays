#!/bin/bash
hostname=$(hostnamectl hostname)
monitors=$(xrandr -q | grep -w "connected" | wc -l)
if [[ $hostname = "bean" ]]; then
    xrandr --output DisplayPort-0 --primary --auto --output HDMI-A-0 --left-of DisplayPort-0 --auto
elif [[ $hostname = "lettuce" && $monitors == 3 ]]; then
    xrandr --output DP1 --auto --output DP2 --left-of DP1 --primary --auto --output eDP1 --off
fi
