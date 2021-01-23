local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local cpu = {}

local icon = {
    widget = wibox.container.background,
    fg = beautiful.bg_urgent,
    {
        id = 'text_value',
        widget = wibox.widget.textbox,
        markup = ''
    },
}

local status_watch, status_watch_timer = awful.widget.watch({"bash", "-c", "sensors | grep 'Core 0' | awk {'print $3'} | cut -c 2- | rev | cut -c  4- | rev"}, 10) 

table.insert(icon, status_watch)
--table.get_children_by_id('text_value'):set_font(theme.battery_icon_font)

cpu = {
    -- icon
    icon,
    -- space - could be replaced with a separator
    {
        widget = wibox.widget.textbox(),
        markup = ' '
    },
    -- capacity text value
    status_watch,
    -- units
    {
        widget = wibox.widget.textbox(),
        markup = '°C'
    },
    layout = wibox.layout.fixed.horizontal
}

return cpu 
