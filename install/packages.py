# list of packages to be installed by install.py

WAYLAND = True
INSTALL_SECURITY_TOOLS = True

AUR_PKGS = ["dmenu2", "nordic-theme-git", "dracula-gtk-theme"]


ARCH_PKGS = [
    "alacritty",
    "base",
    "bind",
    "blueman",
    "brightnessctl",
    "bspwm",
    "code",
    "chromium",
    "curl",
    "docker",
    "dkms",
    "efibootmgr",
    "firefox",
    "glances",
    "gnome-disk-utility",
    "gnome-keyring",
    "go",
    "graphicsmagick",
    "gst-plugin-pipewire",
    "gvfs-smb",
    "htop",
    "i3lock",
    "imv",
    "intel-media-driver",
    "intel-ucode",
    "libva-intel-driver",
    "light",
    "linux-firmware",
    "linux-headers",
    "lxappearance",
    "man-db",
    "nano",
    "nitrogen",
    "nemo",
    "neovim",
    "network-manager-applet",
    "networkmanager-l2tp",
    "networkmanager-pptp",
    "nmap",
    "openssh",
    "openvpn",
    "otf-font-awesome",
    "papirus-icon-theme",
    "pavucontrol",
    "pipewire-alsa",
    "pipewire-jack",
    "pipewire-pulse",
    "pluma",
    "python-neovim",
    "python-black",
    "qemu",
    "qtile",
    "rizin",
    "rz-cutter",
    "rz-ghidra",
    "smartmontools",
    "strace",
    "strongswan",
    "thunar",
    "transmission-gtk",
    "ttf-sourcecode-pro-nerd",
    "unzip",
    "usbutils",
    "vala",
    "vim",
    "virt-manager",
    "vulkan-intel",
    "wget",
    "wireless_tools",
    "xdg-user-dirs",
    "xfce4-clipman-plugin",
    "xorg-server",
    "xorg-xinit",
]

if WAYLAND:
    AUR_PKGS.extend(
        [
            "grimshot",
            "rofi-lbonn-wayland-git",
            "sway",
            "swaylock-effects",
            "wdisplays",
            "wlogout",
        ]
    )
    ARCH_PKGS.extend(
        [
            "fuzzel",
            "swayidle",
            "qt5-wayland",
            "waybar",
            "wofi",
            "wl-clipboard",
            "xorg-xwayland",
        ]
    )

if INSTALL_SECURITY_TOOLS:
    ARCH_PKGS.extend(
        [
            "metasploit",
            "exploitdb",
            "hydra",
            "john",
            "hashcat",
            "hashcat-utils",
        ]
    )
