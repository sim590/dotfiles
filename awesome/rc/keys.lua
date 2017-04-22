local awful = require("awful")
local naughty = require("naughty")
local menubar = require("menubar")
local revelation = require("revelation")
local gears = require("gears")

require("rc.utils")
require("rc.xrandr")  -- use xrandr to cycle through display layouts

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
    -- BUG: dm-tool ne verrouille pas vraiment la session...
    awful.key({ modkey,	"Shift"   }, "Delete", function () awful.util.spawn("i3lock-fancy -- scrot -z") end),
    --hook (/etc/systemd/system/dmlock.service) is triggered when suspending
    awful.key({ modkey }, "F3", function ()
        awful.spawn("i3lock-fancy -- scrot -z")
        awful.spawn("systemctl suspend")
    end),
    awful.key({ modkey }, "F4", function ()
        awful.spawn("i3lock-fancy -- scrot -z")
        awful.spawn.with_shell("sleep 2 && systemctl hibernate")
    end),
    awful.key({			  }, "Print", function () awful.spawn("gnome-screenshot -i") end),
    awful.key({			  }, "XF86TouchpadToggle", function () awful.spawn("/home/simon/bin/toggle-touchpad") end),
    awful.key({	          }, "XF86MonBrightnessUp", function () awful.spawn("light -A 15") end),
    awful.key({	          }, "XF86MonBrightnessDown", function () awful.spawn("light -U 15") end),
    awful.key({modkey,	          }, "F1", revelation),
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
    awful.key({     }, "XF86AudioRaiseVolume", function() awful.spawn.with_shell(pamixer .. " " .. "-i 5") end),
    awful.key({     }, "XF86AudioLowerVolume", function() awful.spawn.with_shell(pamixer .. " " .. "-d 5") end),
    awful.key({     }, "XF86AudioMute", function() awful.spawn.with_shell(pamixer .. " " .. "-t") end),
    awful.key({     }, "XF86AudioMicMute", function() awful.spawn("amixer set Capture toggle") end),
    --
    -- {{ music }} --
    -- ducky mini conf
    awful.key({modkey, "Shift"}, "p", function () awful.spawn(mpd_remote .. " toggle") end),
    awful.key({modkey, "Mod5" }, ",", function () awful.spawn(mpd_remote .. " prev") end),
    awful.key({modkey, "Mod5" }, ".", function () awful.spawn(mpd_remote .. " next") end),
    -- normal
    awful.key({ }, "XF86AudioStop", function () awful.spawn(mpd_remote .. " stop") end),
    awful.key({ }, "XF86AudioPlay", function () awful.spawn(mpd_remote .. " toggle") end),
    awful.key({ }, "XF86AudioPrev", function () awful.spawn(mpd_remote .. " prev") end),
    awful.key({ }, "XF86AudioNext", function () awful.spawn(mpd_remote .. " next") end),
    --
    -- {{ my apps }}--
    awful.key({ modkey,         }, "c", function ()
        local url = io.popen("xsel -ob"):read('*l')
        naughty.notify({ title = "Casting on local chromecast",
                         text = url })
        awful.spawn(terminal_cmd .. 'castnow' .. ' "' .. url .. '"')
    end),
    awful.key({ modkey,         }, "v", function ()
        local url = io.popen("xsel -ob"):read('*l')
        naughty.notify({ title = "Starting mpv",
                         text = url })
        awful.spawn('mpv --force-window --no-terminal --keep-open=yes --ytdl --ytdl-format=22' .. ' "' .. url .. '"')
    end),
    awful.key({ modkey,         }, "z", function () awful.spawn(browser) end),
    awful.key({ modkey, "Shift" }, "z", function () awful.spawn.with_shell(scnd_browser) end),
    awful.key({ modkey, "Shift" }, "t", function () awful.spawn(terminal_cmd .. 'htop') end),
    awful.key({ modkey,         }, "a", function () awful.spawn(terminal_cmd .. 'ranger') end),
    awful.key({ modkey,         }, "i", start_mail),
    awful.key({ modkey, "Control" }, "i", set_one_window_sidemenu_style),
    awful.key({ modkey, "Shift" }, "i", start_mail_calendar),
    awful.key({ modkey,         }, "e", function () awful.spawn(editor_cmd) end),
    awful.key({ modkey,         }, "d", function () awful.spawn(terminal_cmd .. mpdclient) end),
    awful.key({ modkey, "Shift" }, "d",
        function ()
            awful.spawn.with_shell(terminal_cmd .. vmixer)
            gears.timer.start_new(0.1, function ()
                awful.spawn(terminal_cmd .. mpdclient .. " " .. "-s" .. "playlist")
                gears.timer.start_new(0.1, function ()
                    awful.spawn(terminal_cmd .. mpdclient .. " " .. "-s" .. "media_library")
                    gears.timer.start_new(0.1, function () awful.spawn(terminal_cmd .. mpdclient .. " " .. "-s" .. "search_engine") end)
                end)
            end)
        end),
    awful.key({ modkey, "Control", "Shift" }, "s", synergy),
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
        -- TODO: marche po sur thinkpad (awesome 4.0)
        local clients = awful.screen.focused().selected_tag:clients()
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
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal_cmd .. "bash") end),
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
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
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
                     local s = awful.screen.focused()
                     local tag = s.tags[i]
                     local this_tag = s.selected_tag

                     if #tag:clients() == 0 then
                         -- replicate layout on target.
                         tag.layout = this_tag.layout
                         tag.master_count = this_tag.master_count
                         tag.master_width_factor = this_tag.master_width_factor
                     end
                     if clients then
                         for _,c in pairs(clients) do
                             c:move_to_tag(tag)
                         end
                     end
                 end)
        )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

