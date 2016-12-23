local awful = require("awful")
local utils = require("rc.utils")

-- {{{ Autostart applications
run_once("/home/simon/bin/set_keyboard")
run_once("start-pulseaudio-x11")
run_once("light-locker --lock-after-screensaver=0")
run_once("nm-applet")
run_once("system-config-printer-applet")
run_once("urxvtd")
awful.util.spawn("xrdb ~/.Xresources") -- fixing issue about perl extension for font resize that doesn't work properly each startup..
run_once("xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &")
-- }}}
