#!/bin/bash

# color escape codes
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
NONE='\033[0m'

colors=$(ls ../colors/)

# files that need to be changes
files=(
    "../bspwm/bspwmrc"
    "../sxhkd/sxhkdrc"
    "../polybar/config.ini"
    "./test.txt"
)

clear

echo -e "${GREEN}What theme is currently in use?${NONE}"
select color in $colors
do
    curtheme=$color
    break
done


echo -e "${GREEN}What theme do you want to use?${NONE}"
select color in $colors
do
    newtheme=$color
    break
done

oldcolor9='#ff5566'
newcolor9='#ff4466'

for file in ${files[@]}
do
    echo $file
    sed -i "s/${oldcolor9}/${newcolor9}/g" $file
done
