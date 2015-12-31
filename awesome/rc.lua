-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")
--vicious.contrib = require("vicious.contrib")
local lain      = require("lain")
local revelation = require("revelation")

menubar.cache_entries = true
app_folders = { "/usr/share/applications/", "~/.local/share/applications/" }
menubar.refresh()
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end
run_once("start-pulseaudio-x11")
run_once("nm-applet")
run_once("system-config-printer-applet")
run_once("urxvtd")
awful.util.spawn("xrdb ~/.Xresources") -- fixing issue about perl extension for font resize that doesn't work properly each startup..
-- }}}

-- Starts syenrgyc on synergyc_host and synergys on the this machine. This
-- requires the remote host permits ssh acces to $USER with ssh key.
function synergy(host)
    if host then synergyc_host = host else synergyc_host = 'hydralisk.local' end

    -- {{ little hack to get my ip address
    socket = require("socket")
    mysocket = socket.udp()
    mysocket:setpeername('8.8.8.8', "80")
    myip,_ = mysocket:getsockname()
    -- }}

    --restarting synergyc on the remote host before starting synergy server.
    synergy_call = 'ssh -o StrictHostKeyChecking=no ' ..  synergyc_host ..
        ' ' .. '"pkill -u $USER -x synergyc ; synergyc ' ..  myip .. '"'
    j = 0
    local synergied
    repeat
        synergied = {io.popen(synergy_call):close()}
        j = j + 1

        -- wait a second
        t0 = os.clock()
        while os.clock() - t0 <= 1 do end
    until synergied[1] or j == 2 -- this let ssh/avahi a chance to resolve the host.

    if synergied[1] then
        notify_text = "Starting synergyc on " .. synergyc_host .. "..."
        run_once('synergys')
    else
        notify_text = "Failed to connect to remote host \"" .. synergyc_host .. "\"..."
    end
    naughty.notify({
        title = "Synergy",
        text  = notify_text
    })
end

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/usr/share/awesome/themes/default/theme.lua")
revelation.init()

-- Setup directories
home_dir = os.getenv("HOME")
config_dir = (home_dir .."/.config/awesome/")
themes_dir = (config_dir .. "/" .. "themes")
my_theme = "powerarrow-darker"

beautiful.init(themes_dir .. "/" .. my_theme .. "/" .. "theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
terminal_cmd = terminal .. " -e "
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal_cmd .. editor

-- applications
browser = "qutebrowser"
mail         = terminal_cmd .. "mutt"
mpdclient    = terminal_cmd .. "ncmpcpp"
image_viewer = "gpicview"

icon_exec    = home_dir .. "/bin/x-icon"
icon_dir = home_dir .. "/.local/share/applications/"


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Wallpaper
--if beautiful.wallpaper then
    --for s = 1, screen.count() do
	--gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    --end
--end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "α", "🌎", "✉", "π", "ε", "ζ", "η", "♫" }, s, layouts[1])
    --tags[s] = awful.tag({"➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒"}, s, layouts[1]) -- numbers in black circle
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal_cmd .. "man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
markup = lain.util.markup
-- Textclock
mytextclock = awful.widget.textclock(" %a %d %b  %H:%M")

-- calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })

-- {{ Time and Date Widget }} --
tdwidget = wibox.widget.textbox()
vicious.register(tdwidget, vicious.widgets.date, '<span font="Inconsolata 11" color="#AAAAAA" background="#1F2428"> %A, %b %d %H:%M </span>', 20)

-- Coretemp
--tempicon = wibox.widget.imagebox(beautiful.widget_temp)
--tempwidget = lain.widgets.temp({
    --settings = function()
        --widget:set_text(" " .. coretemp_now .. "°C ")
    --end
--})

--{{ Battery Widget }} --

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

-- {{ cmus-status Widget }} --
--cmus_status = wibox.widget.textbox()
--vicious.register(cmus_status, vicious.contrib.cmus, '<span font="Inconsolata 11" color="#AAAAAA" background="#1F2428"> $1 - $2 </span>', nil)

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
mailicon = wibox.widget.imagebox(beautiful.widget_mail)
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
mailwidget = wibox.widget.background(lain.widgets.imap({
    timeout  = 180,
    server   = "imap.foomail.com",
    mail     = "foo@foomail.com",
    password = "foopwd",
    settings = function()
        if mailcount > 0 then
            widget:set_text(" " .. mailcount .. " ")
            mailicon:set_image(beautiful.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(beautiful.widget_mail)
        end
    end
}), "#313131")

-- MPD
mpdicon = wibox.widget.imagebox(beautiful.widget_music)
mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(mpdclient) end)))
mpdwidget = lain.widgets.mpd({
    music_dir = home_dir .. "/Musique",
    password = "q1w2e3r4",
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

--------------------
--  Conky config  --
--------------------

local conky = {}
conky.conky = nil
conky.get_conky = function(default)
    if conky.conky and conky.conky.valid then
        return conky.conky
    end

    conky.conky = awful.client.iterate(function(c) return c.class == "Conky" end)()
    return conky.conky or default
end

conky.raise_conky = function()
    conky.get_conky({}).ontop = true
end

conky.lower_conky = function()
    conky.get_conky({}).ontop = false
end

local t = timer({ timeout = 0.01 })
t:connect_signal("timeout", function()
    t:stop()
    conky.lower_conky()
end)
conky.lower_conky_delayed = function()
    t:again()
end

conky.toggle_conky = function()
    local conky = conky.get_conky({})
    conky.ontop = not conky.ontop
end

-------------------------------
--  Multiple screens config  --
-------------------------------

xrandr = {}
-- Get active outputs
xrandr.outputs = function()
    local outputs = {}
    local xrandr = io.popen("xrandr -q")
    if xrandr then
        for line in xrandr:lines() do
            output = line:match("^([%w-]+) connected ")
            if output then
                outputs[#outputs + 1] = output
            end
        end
        xrandr:close()
    end

    return outputs
end

xrandr.arrange = function(out)
    -- We need to enumerate all the way to combinate output. We assume
    -- we want only an horizontal layout.
    local choices  = {}
    local previous = { {} }
    for i = 1, #out do
        -- Find all permutation of length `i`: we take the permutation
        -- of length `i-1` and for each of them, we create new
        -- permutations by adding each output at the end of it if it is
        -- not already present.
        local new = {}
        for _, p in pairs(previous) do
            for _, o in pairs(out) do
                if not awful.util.table.hasitem(p, o) then
                    new[#new + 1] = awful.util.table.join(p, {o})
                end
            end
        end
        choices = awful.util.table.join(choices, new)
        previous = new
    end

    return choices
end

-- Build available choices
xrandr.menu = function()
    local menu = {}
    local out = xrandr.outputs()
    local choices = xrandr.arrange(out)

    for _, choice in pairs(choices) do
        local cmd = "xrandr"
        -- Enabled outputs
        for i, o in pairs(choice) do
            cmd = cmd .. " --output " .. o .. " --auto"
            if i > 1 then
                cmd = cmd .. " --right-of " .. choice[i-1]
            end
        end
        -- Disabled outputs
        for _, o in pairs(out) do
            if not awful.util.table.hasitem(choice, o) then
                cmd = cmd .. " --output " .. o .. " --off"
            end
        end

        local label = ""
        if #choice == 1 then
            label = 'Only <span weight="bold">' .. choice[1] .. '</span>'
        else
            for i, o in pairs(choice) do
                if i > 1 then label = label .. " + " end
                label = label .. '<span weight="bold">' .. o .. '</span>'
            end
        end

        menu[#menu + 1] = { label,
        cmd,
        "/usr/share/icons/Tango/32x32/devices/display.png"}
    end

    return menu
end

-- Display xrandr notifications from choices
local state = { iterator = nil,
timer = nil,
cid = nil }
xrandr.xrandr = function()
    -- Stop any previous timer
    if state.timer then
        state.timer:stop()
        state.timer = nil
    end

    -- Build the list of choices
    if not state.iterator then
        state.iterator = awful.util.table.iterate(xrandr.menu(),
        function() return true end)
    end

    -- Select one and display the appropriate notification
    local next  = state.iterator()
    local label, action, icon
    if not next then
        label, icon = "Keep the current configuration", "/usr/share/icons/Tango/32x32/devices/display.png"
        state.iterator = nil
    else
        label, action, icon = unpack(next)
    end
    state.cid = naughty.notify({
        text = label,
        icon = icon,
        timeout = 4,
        screen = mouse.screen, -- Important, not all screens may be visible
        font = "Free Sans 18",
        replaces_id = state.cid
    }).id

    -- Setup the timer
    state.timer = timer { timeout = 4 }
    state.timer:connect_signal("timeout",
    function()
        state.timer:stop()
        state.timer = nil
        state.iterator = nil
        if action then
            awful.util.spawn(action, false)
        end
    end)
    state.timer:start()
end


-- {{ Powerarrow-dark icons }} --
spr = wibox.widget.textbox(' ')
arrl = wibox.widget.imagebox()
arrl:set_image(beautiful.arrl)
arrl_dl = wibox.widget.imagebox()
arrl_dl:set_image(beautiful.arrl_dl)
arrl_ld = wibox.widget.imagebox()
arrl_ld:set_image(beautiful.arrl_ld)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "20" })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(arrl_ld)
    left_layout:add(arrl_dl)
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(arrl_ld)
    right_layout:add(mpdicon)
    right_layout:add(mpdwidgetbg)
    right_layout:add(arrl_dl)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(arrl_ld)
    right_layout:add(arrl_dl)
    --right_layout:add(tempicon)
    --right_layout:add(tempwidget)
    right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(arrl_ld)
    right_layout:add(arrl_dl)
    right_layout:add(mytextclock)
    right_layout:add(arrl_ld)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- {{{ My bindings
    awful.key({ modkey,	"Shift"   }, "Delete", function () awful.util.spawn("slimlock") end),
    awful.key({ modkey }, "F3", function () awful.util.spawn_with_shell("slimlock & systemctl suspend") end),
    awful.key({			  }, "Print", function () awful.util.spawn("/home/simon/bin/sshot") end),
    awful.key({ modkey    }, "Print", function ()
        -------------------------------------------------------------
        --  Takes a screenshot and opens it right after it's done  --
        -------------------------------------------------------------
        awful.util.spawn("/home/simon/bin/sshot")
        os.execute("sleep 2")
        local filenames = {}
        local pipe_file = io.popen("find /tmp -maxdepth 1 -name sshot\\[0-9\\]\\*.png", "r")
        for line in pipe_file:lines() do
            table.insert(filenames, line)
        end
        io.close(pipe_file)
        table.sort(filenames, function (a, b) return tonumber(a:match("%d+")) >= tonumber(b:match("%d+")) end)
        awful.util.spawn(image_viewer .. " " .. filenames[1])
    end),
    awful.key({			  }, "XF86TouchpadToggle", function () awful.util.spawn("/home/simon/bin/toggle-touchpad") end),
    awful.key({	          }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 15") end),
    awful.key({	          }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 15") end),
    awful.key({modkey,	          }, "F1", revelation),
    -- TODO: bouton toggle pour screen saver ou pas
    --awful.key({},  "Pause",
        --function ()
            --local screen_saver_timeout = tonumber(io.popen("xset q | grep timeout | gawk '{print $2}'"))
            --if not screen_saver_timeout == nil and not screen_saver_timeout == 0 then
                --os.execute("xset s off")
            --elseif screen_saver_timeout == 0 then
                --os.execute("xset s on")
            --end
        --end),
    -- mount/unmount last plugged-in device
    awful.key({ modkey, "Shift"   }, "m", function ()
        local output = io.popen("lastmount 2>&1", "r"):read('l')
        awful.util.spawn('notify-send "Last plugged-in device" "' .. output .. '"')
    end),
    -- {{ Window control }}
    ---------------------------------------------------------------------
    --  Makes window floating with reasonable 700x475 pixels geometry  --
    ---------------------------------------------------------------------
    awful.key({ modkey, "Control" }, "t", function ()
        local focused_client = awful.client.next(0)
        local w = focused_client.geometry(focused_client).width
        local h = focused_client.geometry(focused_client).height

        awful.client.floating.set(focused_client, true)
        awful.client.moveresize(0,0,700 - w, 475 - h)
        end),
    -- {{ Cycle through screen settings }}
    awful.key({ modkey, }, "F8", xrandr.xrandr),
    -- {{ Volume Control }} --
    awful.key({     }, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer set Master 5%+", false) end),
    awful.key({     }, "XF86AudioLowerVolume", function() awful.util.spawn("amixer set Master 5%-", false) end),
    awful.key({     }, "XF86AudioMute", function() awful.util.spawn("amixer set Master toggle", false) end),
    --
    -- {{ music }} --
    -- ducky mini conf
    awful.key({modkey, "Shift"}, "p", function () awful.util.spawn("mpc toggle") end),
    awful.key({modkey, "Mod5" }, ",", function () awful.util.spawn("mpc prev") end),
    awful.key({modkey, "Mod5" }, ".", function () awful.util.spawn("mpc next") end),
    -- normal
    awful.key({ }, "XF86AudioStop", function () awful.util.spawn("mpc stop") end),
    awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end),
    awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("mpc prev") end),
    awful.key({ }, "XF86AudioNext", function () awful.util.spawn("mpc next") end),
    --
    -- {{ my apps }}--
    awful.key({ modkey,         }, "z", function () awful.util.spawn(browser) end),
    awful.key({ modkey, "Shift" }, "t", function () awful.util.spawn(terminal_cmd .. 'htop') end),
    awful.key({ modkey,         }, "a", function () awful.util.spawn(terminal_cmd .. 'ranger') end),
    awful.key({ modkey,         }, "i", function () awful.util.spawn(mail) end),
    awful.key({ modkey, "Shift" }, "i",
        function ()
            awful.util.spawn(mail)
            awful.util.spawn(icon_exec .. " " .. icon_dir .. "/google-calendar.desktop")
            awful.util.spawn(icon_exec .. " " .. icon_dir .. "/google-keep.desktop")

            --layout conf
            awful.tag.setnmaster(2)
            awful.tag.setmwfact(0.7)
            awful.layout.set(awful.layout.suit.tile)
        end),
    awful.key({ modkey,         }, "e", function () awful.util.spawn(editor_cmd) end),
    awful.key({ modkey,         }, "d", function () awful.util.spawn(mpdclient) end),
    awful.key({ modkey, "Shift" }, "d",
        function ()
            run_once('pavucontrol')
            awful.util.spawn(mpdclient .. " " .. "-s" .. "playlist")
            awful.util.spawn(mpdclient .. " " .. "-s" .. "media_library")
            awful.util.spawn(mpdclient .. " " .. "-s" .. "search_engine")
        end),
    awful.key({ modkey, "Control", "Shift" }, "s", function () synergy() end),
    awful.key({ modkey,         }, "F12", function () awful.util.spawn("okular /home/simon/Documents/Education/UQTR/math-info/2015-hiver/h15-horaire.pdf") end),
    -- }}}
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    -- {{ Move all clients to the first screen }}
    awful.key({ modkey, "Shift" }, "u", function ()
        if client.focus.screen == 1 then return end

        local tags = awful.tag.gettags(client.focus.screen)
        local t_tags = awful.tag.gettags(1)

        for i,tag in pairs(tags) do
            for _,c in pairs(tag:clients()) do
                awful.client.movetoscreen(c, 1)
                awful.client.movetotag(t_tags[i], c)
            end
        end
    end),
    awful.key({ "Mod1", "Control"   }, "o", function ()
        local clients = awful.client.tiled(client.focus.screen)
        if clients then
            for _,cli in pairs(clients) do
                awful.screen.focus(cli.screen)
                awful.client.focus.byidx(0, awful.client.getmaster())
                awful.client.movetoscreen()
            end
        end
    end),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end),
        awful.key({ "Mod1", "Shift" }, "#" .. i + 9,
                  function ()
                      if not client.focus then return end

                      local clients = awful.client.tiled(client.focus.screen)
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if clients then
                          for _ in pairs(clients) do
                              awful.client.movetotag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "Wine", instance = "Battle.net.exe" },
      properties = { floating = true } },
    { rule = { class = "Wine", instance = "Hearthstone.exe" },
      properties = { floating = true } },
    --{ rule_any = { class = { "Battle.net.exe", "Wine" } },
      --properties = { floating = true } },
    --{ rule_any = { class = { "Hearthstone.exe", "Wine" } },
      --properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } }
}
-- }}}

-- {{{ Signals

-- Fullscreen client to trigger disabling DPMS
local fullscreened_clients = {}
local function remove_client(tabl, c)
    local index = awful.util.table.hasitem(tabl, c)
    if index then
        table.remove(tabl, index)
        if #tabl == 0 then
            awful.util.spawn("xset s on")
            awful.util.spawn("xset +dpms")
        end
    end
end

client.connect_signal("property::fullscreen",
function(c)
    if c.fullscreen then
        table.insert(fullscreened_clients, c)
        if #fullscreened_clients == 1 then
            awful.util.spawn("xset s off")
            awful.util.spawn("xset -dpms")
        end
    else
        remove_client(fullscreened_clients, c)
    end
end)

client.connect_signal("unmanage",
function(c)
    if c.fullscreen then
        remove_client(fullscreened_clients, c)
    end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
         awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

-- {{{ Wallpaper
awful.util.spawn_with_shell("~/.fehbg")

client.connect_signal("focus", function(c) c.border_color = "#535d6c" end)
client.connect_signal("unfocus", function(c) c.border_color = "#000000" end)
-- }}}
