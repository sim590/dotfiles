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
lain.widgets.calendar.attach(widgets.mytextclock, { font = "Inconsolata", font_size = 11 })

-- {{ Time and Date Widget }} --
local tdwidget = wibox.widget.textbox()
vicious.register(
    tdwidget,
    vicious.widgets.date,
    '<span font="Inconsolata 11" color="#AAAAAA" background="#1F2428"> %A, %b %d %H:%M </span>',
    20
)

--{{ Battery Widget }} --
-- TODO: check if displayed info is consistent with multiple batteries
widgets.baticon = wibox.widget.imagebox(beautiful.widget_battery)
widgets.batwidget = lain.widgets.bat({
    settings = function()
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

-- {{ Volume Widget }} --
widgets.volicon = wibox.widget.imagebox(beautiful.widget_vol)
widgets.volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            widgets.volicon:set_image(beautiful.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            widgets.volicon:set_image(beautiful.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            widgets.volicon:set_image(beautiful.widget_vol_low)
        else
            widgets.volicon:set_image(beautiful.widget_vol)
        end

        widget:set_text(" " .. volume_now.level .. "% ")
    end,
    timeout = 0.5
})

-- {{ MPD Widget }} --
widgets.mpdicon = wibox.widget.imagebox(beautiful.widget_music)
widgets.mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function()
    awful.spawn_with_shell(utils.terminal_cmd .. utils.mpdclient)
end)))
widgets.mpdwidget = lain.widgets.mpd({
    music_dir = utils.home_dir .. "/Musique",
    password = "q1w2e3r4", -- TODO use `pass` to get password from encrypted files.
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            widgets.mpdicon:set_image(beautiful.widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = " mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            widgets.mpdicon:set_image(beautiful.widget_music)
        end

        widget:set_markup(markup("#EA6F81", artist) .. title)
    end
})
widgets.mpdwidgetbg = wibox.container.background(widgets.mpdwidget, "#313131")

--{{ Coretemp }} --
widgets.tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup.font(nil, " " .. coretemp_now .. "°C "))
    end
})

return widgets

-- vim:set et sw=4 ts=4 tw=120:

