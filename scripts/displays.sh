#!/bin/bash
hostname=$(hostnamectl hostname)
if [[ $hostname = "bean" ]]; then
    echo "hi"
    xrandr --output DisplayPort-0 --primary --auto --output HDMI-A-0 --left-of DisplayPort-0 --auto
fi
