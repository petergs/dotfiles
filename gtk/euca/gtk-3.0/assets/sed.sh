#!/bin/sh
sed -i \
         -e 's/#212620/rgb(0%,0%,0%)/g' \
         -e 's/#cac7c2/rgb(100%,100%,100%)/g' \
    -e 's/#414640/rgb(50%,0%,0%)/g' \
     -e 's/#749c6c/rgb(0%,50%,0%)/g' \
     -e 's/#212620/rgb(50%,0%,50%)/g' \
     -e 's/#cac7c2/rgb(0%,0%,50%)/g' \
	"$@"
