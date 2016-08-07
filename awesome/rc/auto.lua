local awful = require("awful")
local utils = require("rc.utils")

-- {{{ Autostart applications
run_once("start-pulseaudio-x11")
run_once("nm-applet")
run_once("system-config-printer-applet")
run_once("urxvtd")
awful.util.spawn("xrdb ~/.Xresources") -- fixing issue about perl extension for font resize that doesn't work properly each startup..
-- }}}
