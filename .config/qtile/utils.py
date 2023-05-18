import os
import subprocess
from typing import Type

from libqtile import hook
from libqtile.widget.base import _Widget


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
