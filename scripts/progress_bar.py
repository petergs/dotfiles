#!/usr/bin/env python3

import psutil
import json
import subprocess
import sys

EM = "\u2014"
TWO_EM = "\u2e3a"
HEAVY_BOX = "\u2501"
DBL_HEAVY_BOX = "\u254d"
TRPL_HEAVY_BOX = "\u2505"
SMALL_SQ = "\u25a0"
MED_SQ = "\u25fc"
BAR_FG = "#BD93F9"
BAR_BG = "#F8F8F2"


def print_bar(
    cmd,
    bar_char: str = EM,
    line_char="|",
    max_value: int = 100,
    scale: int = 10,
    bar_bg: str = BAR_BG,
    bar_fg: str = BAR_FG,
) -> tuple[str, float]:
    if callable(cmd):
        output = cmd()
    elif type(cmd) in [list, str]:
        output = int(float(subprocess.check_output(cmd, shell=True).decode().strip()))
    elif cmd is None:
        raise TypeError
    else:
        raise NotImplementedError

    y = round(output / scale)
    ramp = bar_char * int((max_value / scale))
    line = f"<span color='{bar_fg}'>{ramp[:y]}</span>{line_char}<span color='{bar_bg}'>{ramp[y:]}</span>"
    return line, output


if __name__ == "__main__":
    if len(sys.argv) > 1:
        mod = sys.argv[1]
    else:
        print("Usage: progress_bar.py [MODULE]")
        exit(1)

    if str.lower(mod) == "ram":

        def _ram_percent() -> float:
            return psutil.virtual_memory().percent

        cmd = _ram_percent
        text, percentage = print_bar(cmd)
        res = {
            "text": text,
            "alt": "alt",
            "tooltip": "tip",
            "class": "",
            "percentage": percentage,
        }
        print(json.dumps(res, ensure_ascii=False))

    elif str.lower(mod) == "brightness":
        cmd = "light"
        text, percentage = print_bar(cmd, bar_char=SMALL_SQ, line_char="")
        res = {
            "text": text,
            "alt": "alt",
            "tooltip": "tip",
            "class": "",
            "percentage": percentage,
        }
        print(json.dumps(res, ensure_ascii=False))

    elif str.lower(mod) == "volume":
        cmd = "pactl get-sink-volume @DEFAULT_SINK@ | head -n1 | awk '{print $5}' | sed 's/.$//'"
        text, percentage = print_bar(cmd, bar_char=SMALL_SQ, line_char="")
        res = {
            "text": text,
            "alt": "alt",
            "tooltip": "tip",
            "class": "",
            "percentage": percentage,
        }
        print(json.dumps(res, ensure_ascii=False))
