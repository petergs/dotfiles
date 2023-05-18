import os
import subprocess
from typing import Type

from libqtile import hook
from libqtile.widget.base import _Widget
from libqtile.widget import Spacer

from Xlib.ext import randr
from Xlib import display


# hooks
@hook.subscribe.startup_once
def autostart() -> None:
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([home])


# other utility functions
def show_widget_if(w: Type[_Widget], b: bool) -> Type[_Widget]:
    if b:
        return w
    else:
        return Spacer(length=0)


def count_displays():
    d = display.Display()
    default_screen = d.get_default_screen()
    root_win = d.screen(default_screen).root
    resources = randr.get_screen_resources(root_win)

    count = 0

    for output in resources.outputs:
        info = d.xrandr_get_output_info(output, resources.config_timestamp)
        if info.crtc != 0:
            count += 1

    return count
