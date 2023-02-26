import os
import psutil
import subprocess

from libqtile import hook


# hooks
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([home])
