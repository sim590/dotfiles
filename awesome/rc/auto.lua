local awful = require("awful")
local utils = require("rc.utils")

-- {{{ Autostart applications
run_once("/home/simon/bin/set_keyboard")
run_once("nm-applet")
run_once("system-config-printer-applet")
run_once("urxvtd")
run_once("xrdb ~/.Xresources")
run_once("xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &")
run_once(redshift.." & disown")
-- }}}
