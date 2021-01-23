local wibox = require("wibox")

local calendar = wibox.widget.calendar.month(os.date('*t'))

return calendar
--