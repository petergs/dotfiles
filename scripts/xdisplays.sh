#!/bin/bash
hostname=$(hostnamectl hostname)
monitors=$(xrandr -q | grep -w "connected" | wc -l)
if [[ $hostname = "bean" ]]; then
    xrandr --output DisplayPort-0 --primary --auto --output HDMI-A-0 --left-of DisplayPort-0 --auto
elif [[ $hostname = "lettuce" && $monitors == 3 ]]; then
    xrandr --output DP2-3 --auto --output DP2-1 --left-of DP2-3 --primary --auto --output eDP1 --off
fi
