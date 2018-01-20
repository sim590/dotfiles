local awful = require("awful")
local utils = require("rc.utils")

-- {{{ Autostart applications
utils.run_once("/home/simon/bin/set_keyboard")
utils.run_once("nm-applet")
utils.run_once("system-config-printer-applet")
utils.run_once("urxvtd")
utils.run_once("xrdb ~/.Xresources")
utils.run_once("xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &")
utils.run_once(utils.redshift.." & disown")
utils.run_once("keynav")
-- }}}
