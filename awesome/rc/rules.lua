local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "okular" },
      properties = { floating = true } },
    { rule = { class = "Pinentry-gtk-2" },
      properties = { floating = true } },
    { rule = { class = "mpv" },
      properties = { floating = true } },
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
      properties = { floating = true } },
}
-- }}}
