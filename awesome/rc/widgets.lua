-- awesome modules
local awful     = require("awful")
local beautiful = require("beautiful")
local lain      = require("lain")
local wibox     = require("wibox")
local vicious   = require("vicious")

-- local modules
local utils = require("rc.utils")

local widgets = { }

local markup = lain.util.markup

-- Textclock
widgets.mytextclock = awful.widget.textclock(" %a %d %b  %H:%M", 10)

-- calendar
lain.widget.cal { attach_to = { widgets.mytextclock } }

--{{ Battery Widget }} --
-- TODO: check if displayed info is consistent with multiple batteries
widgets.baticon = wibox.widget.imagebox(beautiful.widget_battery)
widgets.batwidget = lain.widget.bat({
    ac        = "AC",
    settings  = function()
        if bat_now.status == "Charging" then
            widgets.baticon:set_image(beautiful.widget_ac)
        else -- Discharging
            if bat_now.perc == "N/A" then
                widget:set_markup(" AC ")
                widgets.baticon:set_image(beautiful.widget_ac)
                return
            elseif tonumber(bat_now.perc) <= 5 then
                widgets.baticon:set_image(beautiful.widget_battery_empty)
            elseif tonumber(bat_now.perc) <= 15 then
                widgets.baticon:set_image(beautiful.widget_battery_low)
            else
                widgets.baticon:set_image(beautiful.widget_battery)
            end
        end
        widget:set_markup(" " .. bat_now.perc .. "% ")
    end
})


--{{ Coretemp }} --
widgets.tempwidget = lain.widget.temp {
    settings = function()
        widget:set_markup(markup.font(nil, " " .. coretemp_now .. "°C "))
    end
}

return widgets

-- vim:set et sw=4 ts=4 tw=120:

