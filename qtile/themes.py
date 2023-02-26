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
    ],
)

nord_colors = [
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
    colors=nord_colors,
    border_focus=nord_colors[9],
    border_normal=nord_colors[0],
    bar_bg=nord_colors[0],
    bar_fg=nord_colors[6],
    tag_normal_bg=nord_colors[0],
    tag_focus_bg=nord_colors[3],
    tag_fg=nord_colors[4],
    tag_focus_line=nord_colors[9],
)
