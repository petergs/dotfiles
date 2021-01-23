local awful = require("awful")
local wibox = require("wibox")
local theme = require("theme")
local naughty = require("naughty")

local battery = {}

local status = awful.widget.watch('cat /sys/class/power_supply/BAT0/status', 15, function(widget, stdout)
        -- Icon shape
        if stdout:match("Discharging") then
            widget:set_text("")
        else
            widget:set_text("")
        end
    end)

status:set_font(theme.battery_icon_font)

local icon = {
    widget = wibox.container.background,
    --fg = '#ff0000',
    status,
}

local capacity = awful.widget.watch('cat /sys/class/power_supply/BAT0/capacity', 1)

battery = {
    -- icon
    --status,
    icon,
    -- space - could replaced with a separator
    {
        widget = wibox.widget.textbox(),
        markup = ' '
    },
    -- capacity text value
    capacity,
    -- % sign
    {
        widget = wibox.widget.textbox(),
        markup = '%'
    },
    layout = wibox.layout.fixed.horizontal
}

return battery
