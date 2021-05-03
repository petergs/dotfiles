# Installation
## Overview
This installtion script assumes a Debian environment. If you're not using
Debian, you can use the manual mode to skip the package installation step.
Alternatively, just copy or symlink the required files without this script. 

    cd $HOME
    git clone https://github.com/petergs/dotfiles
    cd ~/dotfiles/install/
    chmod +x ./install.sh
    ./install.sh

# Installation Options
## Workstation
**Workstation** mode installs all packages, symlinks all configs,
and installs addition fonts and programs from Github. This is best for a new
installtion on Debian.

## Server
**Server** mode only symlinks configurations for vim, bash, and tmux. I use
this when I'm just going to using ssh on the box.

## Manual
**Manual** mode uses whiptail to allow you to select which packages to install
and which configs to symlink.

# New Workstation Checklist
1. Run install script
2. Change monitor outputs in Polybar config.ini
3. Change monitor outputs in bspwmrc
4. Set your commit email address in git

# Package Notes
## libxinerama-dev
- prereq for dmenu2
## libxft-dev
- prereq for dmenu2


