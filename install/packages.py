# list of packages to be installed by install.py

WAYLAND = False

AUR_PKGS = [
    "dmenu2",
    "font-manager-git",
    "mozillavpn",
    "nordic-theme-git",
    "ttf-font-icons",
]


ARCH_PKGS = [
    "alacritty",
    "base",
    "bind",
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
    "graphicsmagick",
    "gst-plugin-pipewire",
    "gvfs-smb",
    "htop",
    "imv",
    "intel-media-driver",
    "intel-ucode",
    "libva-intel-driver",
    "light",
    "linux-firmware",
    "linux-headers",
    "man-db",
    "nano",
    "nitrogen",
    "nemo",
    "neovim",
    "network-manager-applet",
    "networkmanager-l2tp",
    "networkmanager-pptp",
    "nmap",
    "ntp",
    "openssh",
    "otf-font-awesome",
    "papirus-icon-theme",
    "pavucontrol",
    "pipewire-alsa",
    "pipewire-jack",
    "pipewire-pulse",
    "pluma",
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
    "unzip",
    "usbutils",
    "vala",
    "vim",
    "virt-manager",
    "vulkan-intel",
    "wget",
    "wireless_tools",
    "wmctl",
    "xorg-server",
    "xfce4-clipman-plugin",
    "xorg-xinit",
]

if WAYLAND:
    AUR_PKGS.extend(
        [
            "grimshot",
            "rofi-lbonn-wayland-git",
            "swaylock-effects",
            "wdisplays",
            "wlogout",
            "wob",
        ]
    )
    ARCH_PKS.extend(
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
