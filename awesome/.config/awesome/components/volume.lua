local awful = require("awful")
local wibox = require("wibox")
local theme = require("theme")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

local volume = {}
local progress = {}

local icon = wibox.widget.textbox()
icon:set_font(theme.battery_icon_font)

local progress = wibox.widget {
    max_value           = 100,
    value               = 0.5,
    forced_height       = 20,
    forced_width        = 100,
    shape               = gears.shape.rounded_bar,
    border_width        = 0,
    widget              = wibox.widget.progressbar,
    color               = beautiful.volume_bar_fg,
    background_color    = beautiful.volume_bar_bg,
    border_color        = beautiful.volume_bar_bg
}

local status_watch, status_watch_timer = awful.widget.watch({"bash", "-c", "pactl list sinks | grep Mute | head -n1 | awk '{print $2}'"},
    15, 
    function(widget, stdout)
        if tostring(stdout):sub(1,#stdout-1) == "no" then
            icon.text = '' 
            progress.color = beautiful.volume_bar_fg
        else
            icon.text = ''
            progress.color = beautiful.volume_bar_muted_fg
        end
    end
) 

-- for use in a dashboard or elsewhere
-- otherwise the volume
local level_watch, level_watch_timer = awful.widget.watch({"bash", "-c", "pactl list sinks | grep Volume | head -n1 | awk '{print $5}' | sed 's/.$//'"}, 
    120, 
    function(widget, stdout)
        widget:set_text(stdout:sub(1, #stdout-1)..'%')
        progress.value = tonumber(stdout)
    end
) 

volume.widget = {
    icon,
    status_watch,
    {
        markup = ' ',
        widget = wibox.widget.textbox
    },
    level_watch, 
    {
        {
            progress,
            layout = wibox.layout.align.vertical,
        },
        margins = 10,
        color = "#0000",
        widget = wibox.container.margin,
    },
    layout = wibox.layout.fixed.horizontal
}



local function volume_notify() 
    naughty.notify({ 
                     title = "Oops, there were errors during startup!",
                     text = 'testing this callback' })
end

function volume:update()
    -- notify if volume.notify == true

    -- update volume_icon
    status_watch_timer:emit_signal("timeout")
    -- update progress and watcher
    level_watch_timer:emit_signal("timeout")
end

function volume:set_widget(widget) 
    return volume.widget
end

volume.progress = progress
volume.level_watch = level_watch
volume.icon = icon
volume.status_watch = status_watch

return volume