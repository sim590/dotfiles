local awful     = require("awful")
local beautiful = require("beautiful")
local menubar   = require("menubar")
local lain      = require("lain")
local wibox     = require("wibox")
local vicious   = require("vicious")

require("rc.utils")

-- {{{ Wibox
markup = lain.util.markup
-- Textclock
mytextclock = awful.widget.textclock(" %a %d %b  %H:%M")

-- calendar
-- FIXME: désactivé: plante avec un errur "nill called value"
-- lain.widgets.calendar:attach(mytextclock, { font = "", font_size = 11 })

-- {{ Time and Date Widget }} --
tdwidget = wibox.widget.textbox()
vicious.register(tdwidget, vicious.widgets.date, '<span font="Inconsolata 11" color="#AAAAAA" background="#1F2428"> %A, %b %d %H:%M </span>', 20)

-- Coretemp
-- TODO
--tempicon = wibox.widget.imagebox(beautiful.widget_temp)
--tempwidget = lain.widgets.temp({
    --settings = function()
        --widget:set_text(" " .. coretemp_now .. "°C ")
    --end
--})

--{{ Battery Widget }} --
-- TODO: check if displayed info is consistent with multiple batteries
baticon = wibox.widget.imagebox(beautiful.widget_battery)
batwidget = lain.widgets.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            widget:set_markup(" AC ")
            baticon:set_image(beautiful.widget_ac)
            return
        elseif tonumber(bat_now.perc) <= 5 then
            baticon:set_image(beautiful.widget_battery_empty)
        elseif tonumber(bat_now.perc) <= 15 then
            baticon:set_image(beautiful.widget_battery_low)
        else
            baticon:set_image(beautiful.widget_battery)
        end
        widget:set_markup(" " .. bat_now.perc .. "% ")
    end
})

-- {{ Volume Widget }} --
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(beautiful.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(beautiful.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(beautiful.widget_vol_low)
        else
            volicon:set_image(beautiful.widget_vol)
        end

        widget:set_text(" " .. volume_now.level .. "% ")
    end,
    timeout = 0.5
})

-- Mail IMAP check
-- mailicon = wibox.widget.imagebox(beautiful.widget_mail)
-- mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
-- mailwidget = wibox.widget.background(lain.widgets.imap({
--     timeout  = 180,
--     server   = "imap.gmail.com",
--     mail     = "", -- TODO use `pass` to get password from encrypted files.
--     password = "",
--     settings = function()
--         if mailcount > 0 then
--             widget:set_text(" " .. mailcount .. " ")
--             mailicon:set_image(beautiful.widget_mail_on)
--         else
--             widget:set_text("")
--             mailicon:set_image(beautiful.widget_mail)
--         end
--     end
-- }), "#313131")

-- MPD
-- function mpd_bar(pass)
--     local naughty = require("naughty")
--     naughty.notify({ title = "My password", text = pass })
-- TODO: need awesome v3.6
-- awful.spawn.easy_async("pass" .. " " .. "personnel/mpd", function(stdout, stderr, r, c)
--     if c == 0 then
--         mpd_pass = stdout
--     end
-- end)
mpdicon = wibox.widget.imagebox(beautiful.widget_music)
mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(terminal_cmd .. mpdclient) end)))
mpdwidget = lain.widgets.mpd({
    music_dir = home_dir .. "/Musique",
    password = "q1w2e3r4", -- TODO use `pass` to get password from encrypted files.
    -- password = mpd_pass,
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(beautiful.widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = " mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(beautiful.widget_music)
        end

        widget:set_markup(markup("#EA6F81", artist) .. title)
    end
})
mpdwidgetbg = wibox.widget.background(mpdwidget, "#313131")
-- local glib = require( "lgi" ).GLib
-- glib.idle_add(glib.PRIORITY_HIGH_IDLE, function() mpdwidget.password = io.popen():lines()() end)
-- end
