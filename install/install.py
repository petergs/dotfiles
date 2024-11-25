# placeholder for wip python install script

## links
"""
https://raw.githubusercontent.com/dracula/alacritty/master/dracula.yml
https://raw.githubusercontent.com/nordtheme/alacritty/main/src/nord.yaml
https://raw.githubusercontent.com/qtile/qtile-examples/52c49816c48fca6eb1bb707cb872e58e460d00fa/traverse.py

TODO:
    - fix creation of clones dir (it's assumed created)
    - fix creation of .local/bin (it's assumed created)
"""

# standard library
import os
import sys
from subprocess import Popen, PIPE, CalledProcessError, check_output
from getpass import getpass

# custom
from packages import ARCH_PKGS, AUR_PKGS

# script location
HOME = os.getenv("HOME")
SCRIPTDIR = os.getcwd()
DOTFILES = f"{HOME}/dotfiles"

# color escape codes
RED = "\033[0;31m"
GREEN = "\033[0;32m"
ORANGE = "\033[0;33m"
BLUE = "\033[0;34m"
NONE = "\033[0m"

# available configurations
DOTS = [
    f"{DOTFILES}/.bashrc",
    f"{DOTFILES}/.tmux.conf",
    f"{DOTFILES}/.vimrc",
    f"{DOTFILES}/.config/alacritty",
    f"{DOTFILES}/.config/dunst",
    f"{DOTFILES}/.config/qtile",
    f"{DOTFILES}/.config/nvim",
    f"{DOTFILES}/.config/sway",
    f"{DOTFILES}/.config/waybar",
    f"{DOTFILES}/.config/wofi",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-appfinder.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-notifyd.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-screenshooter.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-settings-editor.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-settings-manager.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml",
    f"{DOTFILES}/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml",
]


def symlink_dots(dots: list) -> None:
    print(f"\n{GREEN}Symlinking configuration files/directories...{NONE}")
    for item in dots:
        path = item.split(f"{DOTFILES}/")[1:][0]
        dst = f"{HOME}/{path}"
        if os.path.exists(dst):
            resp = input(f"{dst} exists - would you like to overwrite it? (y/N) ")
            if resp.lower() == "y":  # yes we want to overwrite
                os.remove(dst)
                try:
                    os.symlink(src=item, dst=dst)
                except FileExistsError:
                    print(f"{item} exists - skipping symlink")
                else:
                    print(f"Symlinked {item} to {dst} \n")
            else:
                print(f"Skipping {dst}")
        else:
            try:
                os.symlink(src=item, dst=dst)
            except FileExistsError:
                print(f"{item} exists - skipping symlink")
            else:
                print(f"Symlinked {item} to {dst} \n")


def symlink_bin(path: str) -> None:
    print(f"{GREEN}Symlinking ~/.local/bin...{NONE}")
    for item in os.listdir(path):
        dst = f"{HOME}/.local/bin/{item}"
        if not os.path.exists(dst):
            os.symlink(src=f"{path}/{item}", dst=dst)
        else:
            print(f"{dst} already exists - skipping the symlink")


def setup_nvim() -> None:
    print(f"{GREEN}Setting up neovim...{NONE}")
    os.system(f"{DOTFILES}/install/nvim-setup.sh")


def pacman_install() -> None:
    print(f"\n{GREEN}Installing packages...{NONE}")
    password = getpass("Enter your password for running `pacman -S`:")
    cmd = "sudo -S pacman -S --noconfirm --needed".split()
    cmd.extend(ARCH_PKGS)
    p = Popen(cmd, stdin=PIPE)
    p.communicate(password.encode())

    install_yay()


def install_yay() -> None:
    resp = input("Would you like to install AUR packages? (Y/n) ")
    if resp.lower() != "n":
        try:
            s = check_output("pacman -Qi yay > /dev/null", shell=True)
        except CalledProcessError:
            print(f"{BLUE}Installing yay...{NONE}")
            if not os.path.isdir(f"{HOME}/clones"):
                os.mkdir(f"{HOME}/clones")
            p = Popen(
                f"git clone https://aur.archlinux.org/yay.git {HOME}/clones/yay".split()
            )
            os.chdir(f"{HOME}/clones/yay")
            p = Popen("makepkg -si".split())
            os.chdir(SCRIPTDIR)
        else:
            print(f"yay is already installed...{NONE}")

        # cmd = "yay -S --noconfirm".split()
        # cmd.extend(AUR_PKGS)
        # p = Popen(cmd, shell=True)
        print(f"{ORANGE}Installing packages with yay is not yet supported.{NONE}")
        print(
            f"Please install the following packages from the AUR manually: {AUR_PKGS}"
        )

    else:
        print(f"{ORANGE}Skipping yay install and AUR packages...{NONE}")


def print_help() -> None:
    print(
        f"""
{RED}Workstation{NONE} mode installs all packages, symlinks all configs, and installs addition fonts and programs from Github. This is best for a new installation on Arch.
{RED}Server{NONE} mode only symlinks configurations for vim, bash, and tmux.
 """
    )


def check_untracked(dots: list) -> None:
    contents = os.listdir(f"{DOTFILES}/.config/")
    contents = [f"{DOTFILES}/.config/{item}" for item in contents]
    # add top level items not tracked in $HOME/.config like vimrc
    contents.extend([f"{DOTFILES}/{item}" for item in os.listdir(f"{DOTFILES}/")])
    ignore = [
        f"{DOTFILES}/README.md",
        f"{DOTFILES}/.git",
        f"{DOTFILES}/.gitignore",
        f"{DOTFILES}/.local",
        f"{DOTFILES}/scripts",
        f"{DOTFILES}/assets",
        f"{DOTFILES}/.config",
        f"{DOTFILES}/install",
    ]
    untracked = [item for item in contents if item not in dots and item not in ignore]
    if len(untracked) != 0:
        print(f"{RED}The following directories do not have an install command:{NONE}")
        print(untracked)
    else:
        print(f"{GREEN}All files have an install command.{NONE}")


if __name__ == "__main__":
    if len(sys.argv) >= 2:
        if sys.argv[1] == "untracked":
            check_untracked(DOTS)
            exit(0)

    # main installation
    os.system("clear")
    print(f"{GREEN}https://github.com/petergs/dotfiles{NONE}")
    mode = input(
        f"{ORANGE}What installation mode do you want to use?{NONE}\n"
        "1) Workstation\n"
        "2) Server\n"
        "3) Bin Only\n"
        "4) Dots Only\n"
        "5) Help\n"
        "6) Quit\n"
    )
    if mode == "1":  # Workstation
        symlink_dots(DOTS)
        symlink_bin(f"{DOTFILES}/.local/bin")
        pacman_install()
        print(f"{GREEN}Done! Installation is complete.{NONE}\n\n")
    elif mode == "2":  # Server
        # We only want to install these files on a server
        DOTS = [
            f"{DOTFILES}/.bashrc",
            f"{DOTFILES}/.tmux.conf",
            f"{DOTFILES}/.vimrc",
        ]
        symlink_dots(DOTS)
    elif mode == "3":  # Symlink bin
        symlink_bin(f"{DOTFILES}/.local/bin")
    elif mode == "4":  # Symlink dots
        symlink_dots(DOTS)
    elif mode == "5":  # Help
        print_help()
    else:
        # Quit option or an invalid option was entered
        exit(0)
