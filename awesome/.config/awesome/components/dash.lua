-- Load awesomewm libraries
local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

-- Load components
local calendar = require("components.calendar")
local volume = require("components.volume")

local dash = wibox({
    x = 0, --200,
    y = 0, --200,
    visible = false,
    ontop = true,
    type = 'dock',
    screen = screen.primary,
    bg = beautiful.bg_normal.."00",
    bgimage = "/home/ppop/Pictures/wallpapers/euca_blur.jpg",
    height = awful.screen.focused().geometry.height,
    width = awful.screen.focused().geometry.width,
    border_width = 0,
    border_color = "#ff0000",
    color = "#000",
    fg = beautiful.bg_urgent
})

local box_container = wibox.container.background()
box_container.bg = beautiful.bg_normal
box_container.fg = beautiful.fg_normal
--box_container.forced_height = 400 
--box_container.forced_width = 400
local image_container = wibox.container.background()
image_container.bg = beautiful.bg_normal
--image_container.forced_height = height
--image_container.forced_width = 300 

local dash_bg = wibox.container.background()
dash_bg.bg = beautiful.bar_bg_normal
dash_bg.fg = beautiful.bar_fg_normal

---[[

local cal = wibox.widget {
    -- Add margins
    {
        -- Add background color
        {
            -- Center widget_to_be_boxed horizontally
            nil,
            {
                -- Center widget_to_be_boxed vertically
                -- The actual widget goes here
                wibox.widget.calendar.month(os.date('*t')),
                layout = wibox.layout.align.vertical,
            },
            layout = wibox.layout.align.horizontal,
        },
        widget = box_container,
    },
    margins = 15,
    color = beautiful.bar_bg_normal,
    widget = wibox.container.margin,
}--]]--

local image = wibox.widget {
    image = '/home/ppop/Pictures/wallpapers/euca-dash.jpg',
    resize = true,
    widget = wibox.widget.imagebox,
   --forced_width = 1000
}

local image_boxed = wibox.widget {
    -- Add margins
    {
                -- Center widget_to_be_boxed vertically
                -- The actual widget goes here
                image,
                layout = wibox.layout.align.horizontal,
    },
    margins = 15,
    color = beautiful.bar_bg_normal..'00',
    widget = wibox.container.margin,
}--]]--

local dash_right = wibox.widget {
    -- power down, restart, login,
    -- package information,
    -- cpu temp, memory usage, etc
    -- colors
    layout = wibox.layout.ratio.vertical,
}
dash_right:ajust_ratio(2, 0.25, 0.75, 0)

local dash_main = wibox.widget {
    image_boxed,
    dash_right,
    layout = wibox.layout.ratio.horizontal
}
dash_main:ajust_ratio(2, 0.32, 0.68, 0)

dash:setup {
        {
            dash_main, 
            widget = dash_bg,
        },
        margins = 200,
        --color = '#ffff00',
        widget = wibox.container.margin,

}

return dash
