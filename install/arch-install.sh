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
DOTS[Xresources]="ln -sf $HOME/dotfiles/Xresources/.Xresources $HOME/.Xresources"
DOTS[sway]="ln -sf $HOME/dotfiles/sway/config $HOME/.config/"
DOTS[waybar]="ln -sf $HOME/dotfiles/waybar/config $HOME/.config/ && ln -sf $HOME/dotfiles/waybar/style.css $HOME/.config/"

if [ "$1" = "untracked" ]
then 
    echo -e "${RED}The following directories do not have an install command:${NONE}"
    prefix=$PWD/../
    dirs=() 
    for d in $prefix*/ ; do
        dirs+=("$d")
    done

    len=${#prefix}
    ((len+=1))

    for i in ${dirs[@]}
    do
        i=$( echo "$i" | cut -c "$len"- | rev | cut -c2- | rev )
        if [[ ! -v "DOTS[$i]" ]] ; then
            echo -e "$i"
        fi
    done
    exit 0 
fi

clear

echo -e "${GREEN}https://github.com/petergs/dotfiles${NONE}"
echo -e "${ORANGE}What installation mode do you want to use?${NONE}"
modes=("Workstation" "Server" "Manual" "Help" "Quit")
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
            done < $SCRIPTDIR/arch-packages
            break
        ;;

        'Help') 
            echo -e "${RED}Workstation${NONE} mode installs all packages, symlinks all configs, and installs addition fonts and programs from Github. This is best for a new installation on Debian."
            echo -e "${RED}Server${NONE} mode only symlinks configurations for vim, bash, and tmux."
            echo -e "${RED}Manual${NONE} mode uses whiptail to allow you to select which packages to install and which configs to symlink."
        ;;
        'Quit') 
            exit 0
        ;;
    esac
done

# install yay if it's not installed
pacman -Qi yay > /dev/null
if [ $? -eq 0 ]
then
    echo -e "${GREEN}yay is already installed...${NONE}"
else
    echo -e "${GREEN}Installing yay...${NONE}"
    mkdir $HOME/git-repos
    cd $HOME/git-repos/
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi

# install packages
echo -e "${GREEN}Installing packages...${NONE}"
for pkg in ${pkgs[@]}
do
    echo -e "${BLUE}Installing $pkg...${NONE}"
    yay -S $pkg
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


echo -e "${GREEN}Install complete!${NONE}"
