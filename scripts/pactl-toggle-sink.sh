#!/bin/bash

# hacky way to toggle default sink in pulseaudio using pactl
defsink=$(pactl get-default-sink)
nextsink=$(pactl list short sinks | grep -v $defsink | tail -1 | awk '{print $1}')
pactl set-default-sink $nextsink

sinput=$(pactl list short sink-inputs | awk '{print $1}')

(IFS='
'
for inp in $sinput
    do pactl move-sink-input $inp $nextsink
    echo $inp
done)

