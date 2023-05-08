import platform

hostname = platform.node()

# host / display specific variable configuration
if hostname == "tomato":
    fontsize = 16
    barsize = 40
    group_box_padding_x = 10
    spacer_len = 30

    bright_char = "<U+F00E0>"
    charge_char = "<U+F0084>"
    discharge_char = "<U+F0079>"
    empty_char = "<U+F007A>"
    full_char = "<U+F0079>"
else:
    fontsize = 13
    barsize = 30
    group_box_padding_x = 7
    spacer_len = 25

    bright_char = "<U+F5DF>"
    charge_char = "<U+F583>"
    discharge_char = "<U+F578>"
    empty_char = "<U+F58D>"
    full_char = "<U+F58E>"
