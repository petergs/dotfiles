#!/bin/sh
sed -i \
         -e 's/#22313c/rgb(0%,0%,0%)/g' \
         -e 's/#e5e5e5/rgb(100%,100%,100%)/g' \
    -e 's/#424f59/rgb(50%,0%,0%)/g' \
     -e 's/#659063/rgb(0%,50%,0%)/g' \
     -e 's/#424f59/rgb(50%,0%,50%)/g' \
     -e 's/#e5e5e5/rgb(0%,0%,50%)/g' \
	"$@"
