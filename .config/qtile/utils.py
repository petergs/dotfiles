import os
import psutil
import subprocess

from libqtile import hook
from libqtile.widget import base


# hooks
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([home])
