from collections import namedtuple

Theme = namedtuple(
    "Theme",
    [
        "colors",
        "border_focus",
        "border_normal",
        "bar_bg",
        "bar_fg",
        "tag_normal_bg",
        "tag_focus_bg",
        "tag_fg",
        "tag_focus_line",
        "low",
        "medium",
        "high",
        "crit",
        "accent1",
        "accent2",
        "accent3",
    ],
)

_nc = [
    # polar night
    "#2e3440",  # 0 - darkest
    "#3b4252",  # 1
    "#434c5e",  # 2
    "#4c566a",  # 3 - lightest
    # snow storm
    "#d8dee9",  # 4 - darkest
    "#e5e9f0",  # 5
    "#eceff4",  # 6 - lightest
    # frost
    "#8fbcbb",  # 7 - greenest
    "#88c0d0",  # 8
    "#81a1c1",  # 9
    "#5e81ac",  # 10 - bluest
    # aurora
    "#bf616a",  # 11 - red
    "#d08770",  # 12 - orange
    "#ebcb8b",  # 13 - yellow
    "#a3be8c",  # 14 - green
    "#b48ead",  # 15 - purple
]

nord = Theme(
    colors=_nc,
    border_focus=_nc[9],
    border_normal=_nc[0],
    bar_bg=_nc[0],
    bar_fg=_nc[6],
    tag_normal_bg=_nc[0],
    tag_focus_bg=_nc[3],
    tag_fg=_nc[4],
    tag_focus_line=_nc[9],
    low=_nc[14],
    medium=_nc[13],
    high=_nc[12],
    crit=_nc[11],
    accent1=_nc[10],
    accent2=_nc[7],
    accent3=_nc[15],
)

_cc = [
    "#1e1e2e",  # 0 - base
    "#181825",  # 1 - mantle
    "#313244",  # 2 - surface0
    "#45475a",  # 3 - surface1
    "#585b70",  # 4 - surface2
    "#cdd6f4",  # 5 - text
    "#f5e0dc",  # 6 - rosewater
    "#b4befe",  # 7 - lavender
    "#f38ba8",  # 8 - red
    "#fab387",  # 9 - peach
    "#f9e2af",  # 10 - yellow
    "#a6e3a1",  # 11 - green
    "#94e2d5",  # 12 - teal
    "#89b4fa",  # 13 - blue
    "#cba6f7",  # 14 - mauve
    "#f2cdcd",  # 15 - flamingo
]

catppuccin = Theme(
    colors=_cc,
    border_focus=_cc[9],
    border_normal=_cc[0],
    bar_bg=_cc[0],
    bar_fg=_cc[6],
    tag_normal_bg=_cc[0],
    tag_focus_bg=_cc[3],
    tag_fg=_cc[4],
    tag_focus_line=_cc[9],
    low=_cc[11],
    medium=_cc[10],
    high=_cc[9],
    crit=_cc[8],
    accent1=_cc[2],
    accent2=_cc[8],
    accent3=_cc[4],
)

_dc = [
    "#282a36",  # 0 - background color
    "#44475a",  # 1 - current line color
    "#44475a",  # 2 - selection color
    "#f8f8f2",  # 3 - foreground color
    "#6272a4",  # 4 - comment color
    "#8be9fd",  # 5 - cyan color
    "#50fa7b",  # 6 - green color
    "#ffb86c",  # 7 - orange Color
    "#ff79c6",  # 8 - pink color
    "#bd93f9",  # 9 - purple color
    "#ff5555",  # 10 - red color
    "#f1fa8c",  # 11 - yellow color
    "#f1fa8c",  # 12 - repeat
    "#f1fa8c",  # 13 - repeat
    "#f1fa8c",  # 14 - repeat
    "#f1fa8c",  # 15 - repeat
]

dracula = Theme(
    colors=_dc,
    border_focus=_dc[9],
    border_normal=_dc[1],
    bar_bg=_dc[0],
    bar_fg=_dc[6],
    tag_normal_bg=_dc[0],
    tag_focus_bg=_dc[1],
    tag_fg=_dc[1],
    tag_focus_line=_dc[9],
    low=_dc[6],
    medium=_dc[11],
    high=_dc[7],
    crit=_dc[10],
    accent1=_dc[2],
    accent2=_dc[8],
    accent3=_dc[4],
)
