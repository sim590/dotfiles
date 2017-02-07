local awful = require("awful")

-- {{{ Variable definitions
-- Setup directories
home_dir   = os.getenv("HOME")
config_dir = (home_dir .."/.config/awesome/")
themes_dir = (config_dir .. "/" .. "themes")
my_theme   = "powerarrow-darker"

-- This is used later as the default terminal and editor to run.
terminal     = "urxvt"
terminal_cmd = terminal .. " -e "
editor       = os.getenv("EDITOR") or "nvim"
editor_cmd   = terminal_cmd .. editor
-- TODO: use pass for safely getting password
mpd_remote   = "env MPD_HOST=q1w2e3r4@/home/simon/.mpd/socket mpc"

-- applications
browser      = "qutebrowser"
scnd_browser = "chromium"
mail         = "mutt"
mpdclient    = "ncmpcpp"
image_viewer = "gpicview"
pamixer      = "/home/simon/bin/pamixer"

icon_exec = home_dir .. "/bin/x-icon"
icon_dir  = home_dir .. "/.local/share/applications/"


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.spawn.with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

function start_mail()
    awful.spawn(terminal_cmd .. mail)
    -- this triggers offlineimap to use small window for recovering password
    -- (using pass/gpg)
    awful.spawn("pkill -SIGUSR1 offlineimap")
end

function set_one_window_sidemenu_style()
    local t = awful.screen.focused().selected_tag
    t.master_count = 1
    t.master_width_factor = 0.3
    awful.layout.set(awful.layout.suit.tile.left)
end

function start_mail_calendar ()
    start_mail()
    -- starting calendar
    awful.spawn(browser .. " " .. "--target window" .. " " .. "https://calendar.google.com/")
    awful.spawn(browser .. " " .. "--target tab" .. " " .. "https://zimbra.savoirfairelinux.com/zimbra/h/calendar?view=month")

    set_one_window_sidemenu_style()
end

-- TODO: trouver comment utiliser `pass` pour les passwords...
-- {{{ Get passwords
pass_process_list = {}
function pass()
    local helpers      = require("lain.helpers")
    -- passwords = {}
    -- passwords["mpd_bar"] = io.popen("pass" .. " " .. "personnel/mpd"):lines()()
    -- for i,p in pairs(pass_process_list) do p(passwords[i]) end

    mpdwidget.password = "q1w2e3r4"
    -- mpdwidget.password = passwords["mpd_bar"]
end
-- local gears = require("gears")
-- local t = gears.timer({})
-- gears.timer:delayed_call(pass)
-- }}}
