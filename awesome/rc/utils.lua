local awful = require("awful")
local gears = require("gears")

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
pamixer      = home_dir .. "/bin/pamixer"
vmixer        = home_dir .. "/bin/pulsemixer"

icon_exec = home_dir .. "/bin/x-icon"
icon_dir  = home_dir .. "/.local/share/applications/"


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

function async_dummy_cb(stdout, stderr, exitreason, exitcode) end

-- Safely returns return value from os.execute(...)
function os_exec_rv(os_execute_ret)
    package.path = package.path .. ';' .. config_dir .. '/penlight/lua/?.lua'
    require("pl.stringx").import()
    local version = tonumber(_VERSION:split(' ')[2])
    if version > 5.1 then
        return os_execute_ret
    else
        return os_execute_ret == 0
    end
end

-- Gives the name of the program called in the command  ̀cmd`.
local prg_name = function (cmd)
    firstspace = cmd:find(" ")
    if firstspace then
        return cmd:sub(0, firstspace-1)
    else
        return cmd
    end
end

-- Wrapper around pgrep program. Tells whether the called program from the
-- command ̀cmd` is running or not
function pgrep(cmd)
    local prg = prg_name(cmd)
    local ret = os.execute("pgrep -u $USER -x " .. prg .. " > /dev/null")
    return os_exec_rv(ret)
end

-- Wrapper around pkill program. Kills the program. Returns pkill exec code.
function pkill(cmd)
    local prg = prg_name(cmd)
    local ret = os.execute("pkill -u $USER -x " .. prg .. " > /dev/null")
    return os_exec_rv(ret)
end

-- Runs a command only if the program is not already running
function run_once(cmd)
    if not pgrep(cmd) then awful.spawn.with_shell("(" .. cmd .. ")") end
end

function start_mail()
    awful.spawn(terminal_cmd .. mail)
    -- this triggers offlineimap to use small window for recovering password
    -- (using pass/gpg)
    gears.timer.start_new(2, awful.spawn("pkill -SIGUSR1 offlineimap"))
end

function set_one_window_sidemenu_style()
    local t = awful.screen.focused().selected_tag
    t.master_count = 1
    t.master_width_factor = 0.3
    awful.layout.set(awful.layout.suit.tile.left)
end

function start_mail_calendar ()
    awful.spawn(browser .. " " .. "--target window" .. " " .. "https://keep.google.com/")
    gears.timer.start_new(1, function ()
        start_mail()
        -- starting calendar
        awful.spawn(browser .. " " .. "--target window" .. " " .. "https://calendar.google.com/")
        gears.timer.start_new(0.3, function ()
            awful.spawn(browser .. " " .. "--target tab" .. " "
                        ..  "https://www.moodle2.uqam.ca/coursv3/my/"
                        .. " " .. "https://monportail.umontreal.ca/Pages/Accueil.aspx")
        end)
    end)
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
