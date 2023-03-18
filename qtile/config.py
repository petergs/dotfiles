# qtile modules
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# custom modules
from themes import nord, dracula
from utils import *
from sqwid import (
    SpawnWidget,
    ProgressBar,
    CpuRamp,
    RamBar,
    EM,
    TWO_EM,
    HEAVY_BOX,
    DBL_HEAVY_BOX,
)

# other imports
import os


# constants
mod = "mod4"
terminal = guess_terminal()
theme = t = dracula
c = theme.colors
lbw = 3  # layout border width
gaps = 5
font = "SauceCodePro Nerd Font Regular"
fontsize = 13
spacer_len = 25
curly = "{}"
iface = "wlan0"
home = os.path.expanduser("~")


## cmds
dmenu_run = f"""
    dmenu_run -h 30 -w 600 -x 400 \
    -nb '{t.bar_bg}' \
    -nf '{t.tag_fg}' \
    -sb '{t.border_focus}' \
    -sf '{t.bar_bg}' \
    -fn 'Source Code Pro Semibold-11'
    """
get_vol_cmd = (
    "pactl list sinks | grep Volume | head -n1 | awk '{print $5}' | sed 's/.$//'"
)
inc_vol_cmd = "pactl set-sink-volume 0 +5%"
dec_vol_cmd = "pactl set-sink-volume 0 -5%"
mute_vol_cmd = "pactl set-sink-mute 0 toggle"
inc_lite_cmd = "xbacklight -inc 5"
dec_lite_cmd = "xbacklight -dec 5"
get_lite_cmd = "xbacklight"
get_root_storage_cmd = "df -k | awk '{print $5$6}' | grep -x '[0-9].%/' | tr -d '/% '"

ipaddr = (
    f"ip -4 addr show {iface}" + " | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n1",
)


# keybindings
## main keys
keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod],
        "space",
        lazy.spawn(dmenu_run),
        desc="Move window focus to other window",
    ),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(inc_vol_cmd)),
    Key([], "XF86AudioLowerVolume", lazy.spawn(dec_vol_cmd)),
    Key([], "XF86AudioMute", lazy.spawn(mute_vol_cmd)),
    Key([], "XF86MonBrightnessUp", lazy.spawn(inc_lite_cmd)),
    Key([], "XF86MonBrightnessDown", lazy.spawn(dec_lite_cmd)),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating",
    ),
]

groups = [Group(i) for i in "12345"]

## group keys
for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.Columns(
        border_focus=t.border_focus,
        border_normal=t.border_normal,
        border_width=lbw,
        border_on_single=True,
        margin=gaps,
    ),
    layout.Bsp(
        border_focus=t.border_focus,
        border_normal=t.border_normal,
        border_width=lbw,
        border_on_single=True,
        margin=gaps,
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# widget settings
widget_defaults = dict(
    font=font,
    fontsize=fontsize,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    this_current_screen_border=t.tag_focus_line,
                    block_highlight_text_color=t.bar_fg,
                    borderwidth=3,
                    highlight_method="line",
                    background=t.bar_bg,
                    highlight_color=t.tag_focus_bg,
                    disable_drag=True,
                    padding_x=7,
                    margin_x=0,
                ),
                widget.Spacer(length=spacer_len),
                SpawnWidget(
                    fmt=f"<span color='{t.accent2}' size='large'>󰝚</span>  {curly}",
                    cmd="/home/nibbles/dotfiles/scripts/playerctl.sh",
                    update_interval=60,
                ),
                widget.Spacer(bar.STRETCH),
                widget.CurrentLayout(
                    fmt=f"<span color='{t.accent3}' size='large'>󰕰</span> " + "{}"
                ),
                widget.Spacer(length=spacer_len),
                SpawnWidget(
                    fmt=f"<span color='{t.accent2}' size='large'>󰏔</span>" + " {}",
                    cmd="/home/nibbles/dotfiles/scripts/count-pacman-updates.sh",
                    update_interval=6000,
                ),
                widget.Spacer(length=spacer_len),
                widget.Backlight(
                    fmt="<span size='large'></span>  {}",
                    backlight_name="intel_backlight",
                    brightness_file="brightness",
                    markup=True,
                ),
                ProgressBar(
                    update_interval=0.1,
                    bar_char="栗",
                    line_char="",
                    bar_fg=t.border_focus,
                    check_output_cmd=get_lite_cmd,
                ),
                widget.Spacer(length=spacer_len),
                widget.PulseVolume(
                    fmt="<span size='large'></span>  {}",
                    cardid="0",
                    update_interval=0.05
                    # cardid might not be needed
                ),
                ProgressBar(
                    update_interval=0.1,
                    bar_char="栗",
                    line_char="",
                    bar_fg=t.border_focus,
                    check_output_cmd=get_vol_cmd,
                ),
                widget.Spacer(length=spacer_len),
                widget.Battery(
                    format="{char} {percent:2.0%}",
                    charge_char="",
                    discharge_char="",
                    empty_char="",
                    full_char="",
                    low_foreground=t.crit,
                    markup=True,
                ),
                widget.Spacer(length=spacer_len),
                widget.Clock(
                    fmt="<span size='large'></span> {}",
                    markup=True,
                    format="%Y-%m-%d %I:%M %p",
                ),
                widget.Spacer(length=10),
                widget.Systray(background=t.bar_bg),
            ],
            size=30,
            border_width=[0, 0, 0, 0],
            background=t.bar_bg,
        ),
        bottom=bar.Bar(
            [
                widget.Spacer(length=spacer_len),
                SpawnWidget(
                    # fmt=f"<span color='{t.border_focus}' weight='bold'>IP</span>: {curly} ",
                    fmt=f"<span color='{t.border_focus}' weight='bold'>{iface}</span> {curly}",
                    cmd=f"{home}/dotfiles/scripts/ipaddr.sh {iface}",
                    update_interval=60,
                ),
                # widget.Net(
                #     format=f"<span color='{t.border_focus}'>"
                #     + "󰜷</span>:{up}  "
                #     + f"<span color='{t.border_focus}'>󰜮</span>"
                #     + ":{down} ",
                #     interface=iface,
                # ),
                # widget.Spacer(length=spacer_len),
                widget.NetGraph(
                    type="line",
                    graph_color=t.border_focus,
                    border_color=t.bar_bg,
                    border_width=4,
                ),
                widget.Spacer(bar.STRETCH),
                SpawnWidget(
                    fmt=f"<span color='{t.accent1}' weight='bold'>/</span>: {curly}%",
                    cmd=get_root_storage_cmd,
                    update_interval=120,
                ),
                widget.Spacer(length=spacer_len),
                widget.ThermalZone(
                    fmt=" <span color='white'>{}</span>",
                    fgcolor_crit=t.crit,
                    fgcolor_high=t.high,
                    fgcolor_normal=t.medium,
                    markup=True,
                ),
                widget.Spacer(length=spacer_len),
                CpuRamp(
                    fmt="CPU {}",
                    update_interval=1,  # 0.25
                    clr_low=t.low,
                    clr_med=t.medium,
                    clr_high=t.high,
                    clr_crit=t.crit,
                    sensitive=True,
                    markup=True,
                ),
                widget.Spacer(length=spacer_len),
                RamBar(
                    fmt="RAM <span weight='heavy'>{}</span>",
                    update_interval=60,
                    bar_fg=t.border_focus,
                    bar_char=EM,
                    line_char="|",
                ),
                widget.Spacer(length=spacer_len),
            ],
            size=30,
            border_width=[0, 0, 0, 0],
            background=t.bar_bg,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width=lbw,
    border_focus=t.low,
    border_normal=t.border_normal,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
)

# misc settings
# auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
# wmname = "LG3D"
