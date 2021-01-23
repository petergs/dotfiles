
local awful = require("awful")
local wibox = require("wibox")
local theme = require("theme")
local gears = require("gears")
local beautiful = require("beautiful")

local brightness = {}

local icon = wibox.widget.textbox()
icon:set_font("Source Code Pro 64")
icon.text = ''

local brightness_bar = wibox.widget {
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

local status_watch, status_watch_timer = awful.widget.watch("xbacklight",
    15, 
    function(widget, stdout)
        widget:set_text(math.floor(tonumber(stdout:sub(1, #stdout-1)))..'%') 
        brightness_bar.value = tonumber(stdout:sub(1, #stdout-1))
    end
) 


noti = wibox({
    x = awful.screen.focused().geometry.width/2 - 100,
    y = awful.screen.focused().geometry.height - 300,
    visible = false,
    ontop = true,
    type = 'dock',
    screen = screen.primary,
    bg = beautiful.bg_normal..'55',
    height = 180, 
    width = 200,
    border_width = 0,
    border_color = beautiful.bar_bg_normal,
})

brightness.widget = {
    {
        icon,
        top = 20,
        left = 58,
        right = 54,
        color = "#0000",
        widget = wibox.container.margin,
    },
    {
        status_watch,
        top = 10,
        left = 87,
        right = 80,
        color = "#0000",
        widget = wibox.container.margin,
    },
    {
        brightness_bar,
        top = 10,
        left = 50,
        right = 50,
        color = "#0000",
        widget = wibox.container.margin,
    },
    layout = wibox.layout.fixed.vertical
}

noti:setup {
    brightness.widget,
    layout = wibox.layout.fixed.horizontal
}

function brightness:inc()
    awful.spawn.with_shell('xbacklight -inc 10')
    self.update()
end

function brightness:dec()
    awful.spawn.with_shell('xbacklight -dec 10')
    self.update()
end

function brightness:update()
    noti.visible = true
    local hide = timer({ timeout = 3 })
    hide:connect_signal("timeout", 
        function ()
            noti.visible=false
            hide:stop() 
        end
    )
    
    hide:start()

    -- update volume_icon
    status_watch_timer:emit_signal("timeout")
    -- update progress and watcher
    --level_watch_timer:emit_signal("timeout")
end

brightness.icon = icon
brightness.status_watch = status_watch
brightness.brightness_bar = brightness_bar

return brightness 