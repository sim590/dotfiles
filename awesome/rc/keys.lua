local awful         = require("awful")
local screen        = require("screen")
local naughty       = require("naughty")
local menubar       = require("menubar")
local revelation = require("revelation")
local gears         = require("gears")

local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable VIM help for hotkeys widget when client with matching name is opened:
require("awful.hotkeys_popup.keys.vim")
require("awful.hotkeys_popup.keys.qutebrowser")

local utils = require("rc.utils")
local xrandr = require("rc.xrandr")  -- use xrandr to cycle through display layouts

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- TODO: add {description, group} for each keybindings
    -- {{{ My bindings
    awful.key({ modkey,	"Shift"   }, "Delete", function () awful.util.spawn("i3lock-fancy -- scrot -z") end),
    awful.key({ modkey }, "F3", function ()
        awful.spawn.easy_async("i3lock-fancy -- scrot -z", utils.async_dummy_cb)
        awful.spawn.easy_async("bash -c 'sleep ".. (screen:count() > 1 and '3' or '2') .." ; systemctl suspend'", utils.async_dummy_cb)
    end),
    awful.key({ modkey }, "F4", function ()
        awful.spawn.easy_async("i3lock-fancy -- scrot -z", utils.async_dummy_cb)
        awful.spawn.easy_async("bash -c 'sleep ".. (screen:count() > 1 and '3' or '2') .." ; systemctl hibernate'", utils.async_dummy_cb)
    end),
    awful.key({			  }, "Print", function () awful.spawn("gnome-screenshot -i") end),
    awful.key({			  }, "XF86TouchpadToggle", function () awful.spawn("/home/simon/bin/toggle-touchpad") end),
    awful.key({	          }, "XF86MonBrightnessUp", function () awful.spawn("light -A 15") end),
    awful.key({	          }, "XF86MonBrightnessDown", function () awful.spawn("light -U 15") end),
    awful.key({	modkey, "Shift" }, "s", function ()
        if not utils.pgrep(utils.redshift) then
            awful.spawn(utils.redshift)
        else
            utils.pkill(utils.redshift)
        end
    end),
    awful.key({modkey,	          }, "F1", function ()
			-- go around the bug:
			-- https://github.com/guotsuan/awesome-revelation/issues/29
			if screen:count() == 1 then
				revelation()
			end
		end),
    -- {{ Window control }}
    ---------------------------------------------------------------------
    --  Makes window floating with reasonable 700x475 pixels geometry  --
    ---------------------------------------------------------------------
    awful.key({ modkey, "Control" }, "t", function ()
        local focused_client = awful.client.next(0)
        local w = focused_client.geometry(focused_client).width
        local h = focused_client.geometry(focused_client).height
        local sg = client.focus.screen.geometry

        awful.client.floating.set(focused_client, true)
        awful.client.moveresize(0,0,.75*sg.width-w, .75*sg.height-h)
        end),
    -- {{ Cycle through screen settings }}
    awful.key({ modkey, }, "F8", xrandr.xrandr),
    -- {{ Volume Control }} --
    awful.key({     }, "XF86AudioRaiseVolume", function() awful.spawn.with_shell(utils.pamixer .. " " .. "-i 5") end),
    awful.key({     }, "XF86AudioLowerVolume", function() awful.spawn.with_shell(utils.pamixer .. " " .. "-d 5") end),
    awful.key({     }, "XF86AudioMute", function() awful.spawn.with_shell(utils.pamixer .. " " .. "-t") end),
    awful.key({     }, "XF86AudioMicMute", function() awful.spawn("amixer set Capture toggle") end),
    --
    -- {{ music }} --
    -- ducky mini conf
    awful.key({modkey, "Shift"}, "p", function () awful.spawn(utils.mpd_remote .. " toggle") end),
    awful.key({modkey, "Mod5" }, ",", function () awful.spawn(utils.mpd_remote .. " prev") end),
    awful.key({modkey, "Mod5" }, ".", function () awful.spawn(utils.mpd_remote .. " next") end),
    -- normal
    awful.key({ }, "XF86AudioStop", function () awful.spawn(utils.mpd_remote .. " stop") end),
    awful.key({ }, "XF86AudioPlay", function () awful.spawn(utils.mpd_remote .. " toggle") end),
    awful.key({ }, "XF86AudioPrev", function () awful.spawn(utils.mpd_remote .. " prev") end),
    awful.key({ }, "XF86AudioNext", function () awful.spawn(utils.mpd_remote .. " next") end),
    --
    -- {{ my apps }}--
    awful.key({ modkey,         }, "c", function ()
        local url = io.popen("xsel -ob"):read('*l')
        naughty.notify({ title = "Casting on local chromecast",
                         text = url })
        awful.spawn(utils.terminal_cmd .. 'castnow' .. ' "' .. url .. '"')
    end),
    awful.key({ modkey,         }, "v", function ()
        local url = io.popen("xsel -ob"):read('*l')
        naughty.notify({ title = "Starting mpv",
                         text = url })
        awful.spawn('mpv --force-window --no-terminal --keep-open=yes --ytdl' .. ' "' .. url .. '"')
    end),
    awful.key({ modkey,         }, "z", function () awful.spawn(utils.browser) end),
    awful.key({ modkey, "Shift" }, "z", function () awful.spawn.with_shell(utils.scnd_browser) end),
    awful.key({ modkey, "Shift" }, "t", function () awful.spawn(utils.terminal_cmd .. 'htop') end),
    awful.key({ modkey,         }, "a", function () awful.spawn(utils.terminal_cmd .. 'ranger') end),
    awful.key({ modkey,         }, "i", utils.start_mail),
    awful.key({ modkey, "Control" }, "i", utils.set_one_window_sidemenu_style),
    awful.key({ modkey, "Shift" }, "i", utils.start_mail_calendar),
    awful.key({ modkey,         }, "e", function () awful.spawn(utils.editor_cmd) end),
    awful.key({ modkey,         }, "d", function () awful.spawn(utils.terminal_cmd .. utils.mpdclient) end),
    awful.key({ modkey, "Shift" }, "d",
        function ()
            awful.spawn.with_shell(utils.terminal_cmd .. utils.vmixer)
            gears.timer.start_new(0.1, function ()
                awful.spawn(utils.terminal_cmd .. utils.mpdclient .. " " .. "-s" .. "playlist")
                gears.timer.start_new(0.1, function ()
                    awful.spawn(utils.terminal_cmd .. utils.mpdclient .. " " .. "-s" .. "media_library")
                    gears.timer.start_new(0.1, function () awful.spawn(utils.terminal_cmd .. utils.mpdclient .. " " .. "-s" .. "search_engine") end)
                end)
            end)
        end),
    awful.key({ modkey, "Control", "Shift" }, "s", synergy),
    -- }}}
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "u",
        function ()
            local tags = awful.tag.gettags(client.focus.screen)
            local t_tags = awful.tag.gettags(1)

            for i,tag in pairs(tags) do
                for _,c in pairs(tag:clients()) do
                    awful.client.movetoscreen(c, 1)
                    awful.client.movetotag(t_tags[i], c)
                end
            end
        end),
    awful.key({ "Mod1", "Control"   }, "o",
        function ()
            local s = awful.screen.focused()
            for _,cli in pairs(s.clients) do
                cli:move_to_screen() -- next screen by default
            end
        end,
        { description = "Move all clients to next screen", group = "client" }),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(utils.terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"}),
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

