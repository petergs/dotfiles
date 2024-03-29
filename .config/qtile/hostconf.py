import platform

hostname = platform.node()

# host / display specific variable configuration
if hostname == "tomato":
    fontsize = 16
    barsize = 40
    group_box_padding_x = 10
    spacer_len = 30
    iface = "wlan0"

    bright_char = "\U000F00E0"
    charge_char = "\U000F0084"
    discharge_char = "\U000F0079"
    empty_char = "\U000F007A"
    full_char = "\U000F1121"
    bar_char = "\u25fc"
elif hostname == "bean":
    fontsize = 13
    barsize = 30
    group_box_padding_x = 7
    spacer_len = 25
    iface = "enp5s0"

    bright_char = "\U0000F5DF"
    charge_char = "\U0000F583"
    discharge_char = "\U0000F578"
    empty_char = "\U0000F58D"
    full_char = "\U0000F58E"
    bar_char = "\u25a0"
else:
    fontsize = 13
    barsize = 30
    group_box_padding_x = 7
    spacer_len = 25
    iface = "wlan0"

    bright_char = "\U0000F522"
    charge_char = "\U000f0084"
    discharge_char = "\U000f0079"
    empty_char = "\U000f007a"
    full_char = "\U000f0079"
    bar_char = "\u25a0"
