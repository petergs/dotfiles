#!/usr/bin/env python3

import math
import psutil
import json

ramp = "▁▂▃▄▅▆▇█"


def print_ramp(cpus: list[float] | float) -> str:
    line = ""
    if isinstance(cpus, float):
        cpus = [cpus]
    for x in cpus:
        bar = get_bar(x)
        line = f"{bar} {line}"
    return line


def get_bar(v: int | float) -> str:
    bar = ""

    val = int(math.ceil(v / 10.0))

    if val >= 8:
        bar = ramp[7]
    else:
        bar = ramp[val]
    return bar


def get_class(p: float) -> str:
    c = ""
    if p >= 60:
        c = "critical"
    elif p >= 40:
        c = "high"
    elif p >= 20:
        c = "medium"
    else:
        c = "low"

    return c


if __name__ == "__main__":
    cpus = psutil.cpu_percent(1, percpu=True)
    ramp = print_ramp(cpus)
    percentage = sum(cpus) / float(len(cpus))
    css_class = get_class(percentage)
    res = {
        "text": ramp,
        "alt": "alt",
        "tooltip": "tip",
        "class": css_class,
        "percentage": percentage,
    }
    print(json.dumps(res, ensure_ascii=False))
