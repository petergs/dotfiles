#!/bin/bash

### hacky way to toggle default sink in pulseaudio using pactl

defsink=$(pactl get-default-sink)
# list all sinks, remove the line with the current default, tail it to ensure
# that we're getting a single entry, then pull just the index column with awk  
nextsink=$(pactl list short sinks | grep -v $defsink | tail -1 | awk '{print $1}')
pactl set-default-sink $nextsink

# newline delimited list of indexes for all sink inputs 
sinput=$(pactl list short sink-inputs | awk '{print $1}')

# iterate over sink-inputs and change the sink to the new default
# seems like this may be unnecessary and just changing the sink for one
# input changes the sink for all
(IFS='
'
for inp in $sinput
    do pactl move-sink-input $inp $nextsink
    echo $inp
done)

