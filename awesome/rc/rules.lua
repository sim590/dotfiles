local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = { border_width = beautiful.border_width,
            border_color     = beautiful.border_normal,
            focus            = awful.client.focus.filter,
            size_hints_honor = false,               -- closes the gaps in between temrinal windows.
            raise            = true,
            keys             = clientkeys,
            buttons          = clientbuttons,
            screen           = awful.screen.preferred,
            placement        = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
            "DTA",  -- Firefox addon DownThemAll.
            "copyq",  -- Includes session name in class.
            "Battle.net.exe",
            "Hearthstone.exe",
        },
        class = {
            "Kodi",
            "anbox",
            "blueman-manager", "Blueman-manager",
            "darktable", "Darktable",
            "libreoffice", "libreoffice-writer", "soffice", "Soffice",
            "system-config-printer", "Scp-dbus-service.py", "system-config-printer", "System-config-printer.py",
            "nm-connection-editor", "Nm-connection-editor",
            "gnome-calculator", "Gnome-calculator",
            "animate-im6.q16", "Animate-im6.q16",
            "Godot_ProjectList", "Godot", "Godot_Engine",
            "synergy", "Synergy",
            "screenkey", "Screenkey",
            "Blender", "Blender",
            "Godot_Engine", "Godot",
            "Arandr",
            "Gpick",
            "Kruler",
            "MessageWin",  -- kalarm.
            "Sxiv",
            "Wpa_gui",
            "pinentry",
            "veromix",
            "gimp" ,
            "okular",
            "mpv",
            "MPlayer",
            "Wine",
            "Zenity",
            "Alarm-clock-applet",
            "xtightvncviewer"},

            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        }, properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
        }, properties = { titlebars_enabled = false }
    },

}
-- }}}
