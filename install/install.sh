#!/bin/bash

# color escape codes
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
NONE='\033[0m'


echo -e "${RED}Cloning git repos for fonts...${NONE}"
DEST=~/git-repos-test
#mkdir $DEST
#git clone https://github.com/adobe-fonts/source-code-pro $DEST/source-code-pro
#git clone https://github.com/google/material-design-icons $DEST/material-design-icons

echo -e "${RED}Copying fonts to ~/.local/share/fonts${NONE}"
cp $DEST/source-code-pro/TTF/SourceCodePro-*.ttf ~/.local/share/fonts
cp $DEST/material-design-icons/font/MaterialIcons*.ttf ~/.local/share/fonts

# update font cache
echo -e "${RED}Updating the font cache${NONE}"
fc-cache

# what do you want installed?
while IFS="" read -r p || [ -n "$p" ]
do
  echo -e "${RED}Installing $p ${NONE}"
  sudo apt install $p
done < ./packages

echo -e "${RED}Cloning git repo for dmenu2...${NONE}"
git clone https://github.com/muff1nman/dmenu2 $DEST/dmenu2

# symlink files
