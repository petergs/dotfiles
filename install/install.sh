#!/bin/bash

# script location
SCRIPTDIR=$PWD

# color escape codes
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
NONE='\033[0m'

# available configurations
declare -A DOTS
DOTS[bash]="ln -sf $HOME/dotfiles/bash/.bashrc $HOME/.bashrc"
DOTS[bspwm]="ln -sf $HOME/dotfiles/bspwm $HOME/.config/"
DOTS[polybar]="ln -sf $HOME/dotfiles/polybar $HOME/.config/"
DOTS[sxhkd]="ln -sf $HOME/dotfiles/sxhkd $HOME/.config/"
DOTS[tmux]="ln -sf $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf"
DOTS[vim]="ln -sf $HOME/dotfiles/vim/.vimrc $HOME/.vimrc"
DOTS[xinit]="ln -sf $HOME/dotfiles/xinit/.xinitrc $HOME/.xinitrc"
DOTS[Xresources]="ln -sf $HOME/dotfiles/Xresources/.Xresources $HOME/.Xresources"

clear

echo -e "${GREEN}https://github.com/petergs/dotfiles${NONE}"
echo -e "${ORANGE}What installation mode do you want to use?${NONE}"
modes=("Workstation" "Server" "Manual" "Help")
select mode in "${modes[@]}"
do 
    # set $pkgs and $configs based on $mode
    case $mode in
        'Manual') 
            # what do you want installed from the repos?
            cmd=(whiptail --separate-output --checklist "Which pkgs do you want to install?" 22 55 16)
            options=()
            while IFS="" read -r pkg || [ -n "$pkg" ]
            do
                options+=("$pkg" "" off)
            done < $SCRIPTDIR/packages

            pkgs=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

            # what configs do you want symlinked?
            cmd=(whiptail --separate-output --checklist "Which configs do you want symlinked?" 22 76 16)
            options=()
            for i in "${!DOTS[@]}"
            do
                options+=("$i" "" off)
            done

            configs=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
            break

        ;;

        'Server') 
            pkgs=()
            configs=(bash vim tmux)
            break
        ;;
        
        'Workstation') 
            while IFS="" read -r pkg || [ -n "$pkg" ]
            do
                pkgs+=("$pkg")
            done < $SCRIPTDIR/packages
            break
        ;;

        'Help') 
            echo -e "${RED}Workstation${NONE} mode installs all packages, symlinks all configs, and installs addition fonts and programs from Github. This is best for a new installation on Debian."
            echo -e "${RED}Server${NONE} mode only symlinks configurations for vim, bash, and tmux."
            echo -e "${RED}Manual${NONE} mode uses whiptail to allow you to select which packages to install and which configs to symlink."
        ;;
    esac
done

# install packages
echo -e "${GREEN}Installing packages...${NONE}"
for pkg in ${pkgs[@]}
do
    echo -e "${BLUE}Installing $pkg...${NONE}"
    sudo apt install $pkg
done

# symlink configs
echo -e "${GREEN}Symlinking configuration files/directories...${NONE}"
for config in ${configs[@]} #${!DOTS[@]}
do
    # pull out the last word (symlink target to backup if it exists)
    target=$(echo ${DOTS[$config]} | awk '{print $NF}')
    if [[ -d $target ]]; then
        cp -r $target$config $target$config.original
    else
        cp $target $target.original
    fi 
    eval ${DOTS[$config]}
done

notes=''

if [[ $mode = 'Workstation' ]] || [[ $mode = 'Manual' ]] 
then
    # install directory
    DEST=$HOME/git-repos-test
    mkdir $DEST

    echo -e "${ORANGE}Do you want to install required fonts (see INSTALL.md)?${NONE} (Y/n)"
    read resp
    case $resp in
        [Nn]* ) 
            notes+='-- Since you opted out of installing additional fonts, remember to edit .Xresources and the polybar config to use different fonts.\n'
            ;;
        * ) 
            echo -e "${RED}Cloning git repos for fonts...${NONE}"
            #git clone https://github.com/adobe-fonts/source-code-pro $DEST/source-code-pro
            #git clone https://github.com/google/material-design-icons $DEST/material-design-icons

            echo -e "${RED}Copying fonts to ~/.local/share/fonts...${NONE}"
            cp $DEST/source-code-pro/TTF/SourceCodePro-*.ttf ~/.local/share/fonts
            cp $DEST/material-design-icons/font/MaterialIcons*.ttf ~/.local/share/fonts

            # update font cache
            echo -e "${RED}Updating the font cache${NONE}"
            fc-cache
        ;;

    esac

    # 
    echo -e "${ORANGE}Do you want to install additional packages from Github (see INSTALL.md)?${NONE} (Y/n)"
    read resp
    case $resp in
        [Nn]* ) 
            notes+='-- Since you opted out of dmenu2, remember to adjust sxhkdrc to use a different launcher.\n'
            ;;
        * ) 
            echo -e "${RED}Cloning git repo for dmenu2...${NONE}"
            git clone https://github.com/muff1nman/dmenu2 $DEST/dmenu2
            cd $DEST/dmenu2
            sudo make clean install
        ;;
    esac
fi

echo -e "${GREEN}Install complete!${NONE}"
echo -e "${notes}"
