local naughty = require("naughty")
local awful = require("awful")
local gears = require("gears")
require("pl.stringx").import()

-- Awesome Mutli-Host
local amh = require("amh")
amh.hosts        = { "hydralisk.local", "ultralisk.local" }
amh.synergy_icon = "/home/simon/.local/share/icons/hicolor/48x48/apps/synergy.png"

-- {{{ Variable definitions
-- Setup directories
local home_dir   = os.getenv("HOME")
local config_dir = (home_dir .."/.config/awesome/")
local themes_dir = (config_dir .. "/" .. "themes")
local my_theme   = "powerarrow-darker"

-- This is used later as the default terminal and editor to run.
local terminal     = "urxvt"
local terminal_cmd = terminal .. " -e "
local editor       = os.getenv("EDITOR") or "vim"
local editor_cmd   = terminal_cmd .. editor
local mpd_remote   = "env MPD_HOST=/home/simon/.mpd/socket mpc"

-- applications
local browser      = "qutebrowser"
local scnd_browser = "chromium"
local mail         = "mutt"
local mpdclient    = "ncmpcpp"
local image_viewer = "gpicview"
local pamixer      = home_dir .. "/bin/pamixer"
local vmixer       = home_dir .. "/bin/pulsemixer"
local redshift     = "redshift -l manual -l 45.55:-73.72 -t 6500:3700"
local i3lockfancy  = "i3lock-fancy -- scrot -z"

local icon_exec = home_dir .. "/bin/x-icon"
local icon_dir  = home_dir .. "/.local/share/applications/"


awful.util.shell = "/bin/bash"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- returns the powerset of a given set
local function powerset(s)
    if not s then return {} end
    local t = {{}}
    for i = 1, #s do
        for j = 1, #t do
            t[#t+1] = {s[i],unpack(t[j])}
        end
    end
    return t
end

local function async_dummy_cb(stdout, stderr, exitreason, exitcode) end

-- Safely returns return value from os.execute(...)
local function os_exec_rv(os_execute_ret)
    local version = tonumber(_VERSION:split(' ')[2])
    if version > 5.1 then
        return os_execute_ret
    else
        return os_execute_ret == 0
    end
end

-- Gives the name of the program called in the command  ̀cmd`.
local function prg_name(cmd)
    firstspace = cmd:find(" ")
    if firstspace then
        return cmd:sub(0, firstspace-1)
    else
        return cmd
    end
end

-- Wrapper around pgrep program. Tells whether the called program from the
-- command ̀cmd` is running or not
local function pgrep(cmd)
    local prg = prg_name(cmd)
    local ret = os.execute("pgrep -u $USER -x " .. prg .. " > /dev/null")
    return os_exec_rv(ret)
end

-- Wrapper around pkill program. Kills the program. Returns pkill exec code.
local function pkill(cmd)
    local prg = prg_name(cmd)
    local ret = os.execute("pkill -u $USER -x " .. prg .. " > /dev/null")
    return os_exec_rv(ret)
end

-- Runs a command only if the program is not already running
local function run_once(cmd)
    if not pgrep(cmd) then awful.spawn.with_shell("(" .. cmd .. ")") end
end

local function start_mail()
    awful.spawn(terminal_cmd .. mail)
    -- this triggers offlineimap to use small window for recovering password
    -- (using pass/gpg)
    gears.timer.start_new(2, awful.spawn("pkill -SIGUSR1 offlineimap"))
end

-- {{ sidemenu

local sidemenu = {
    default_style = {
        master_width_factor = 0.3,
        master_count        = 1,
        layout              = awful.layout.suit.tile.right
    },
    mail_calendar_style = {
        master_width_factor = 0.3,
        master_count = 1,
        layout = awful.layout.suit.tile.left
    },
    browser_news_style = {
        master_width_factor = 0.2,
        master_count = 1,
        layout = awful.layout.suit.tile.right
    }
}

function sidemenu:set_sidemenu_style(args)
    local t = awful.screen.focused().selected_tag
    t.master_width_factor = args and args.master_width_factor or sidemenu.default_style.master_width_factor
    t.master_count        = args and args.master_count        or sidemenu.default_style.master_count
    awful.layout.set(args and args.layout or sidemenu.default_style.layout)
end

-- }}

local function replicate_layout(tagid)
    local s = awful.screen.focused()
    local tag = s.tags[tagid]

    tag.layout = s.selected_tag.layout
    tag.master_count = s.selected_tag.master_count
    tag.master_width_factor = s.selected_tag.master_width_factor
end

local function start_mail_calendar()
    awful.spawn(browser .. " " .. "--target window" .. " " .. "https://keep.google.com/")
    gears.timer.start_new(1, function ()
        start_mail()
        -- starting calendar
        awful.spawn(browser .. " " .. "--target window" .. " " .. "https://calendar.google.com/")
        gears.timer.start_new(0.3, function ()
            awful.spawn(browser .. " " .. "--target tab" .. " " ..  "https://www.moodle2.uqam.ca/coursv3/my/")
        end)
    end)
    sidemenu:set_sidemenu_style(sidemenu.mail_calendar_style)
end

-- Returns the first valid ip address
local function myip()
    socket = require("socket")
    mysocket = socket.udp()
    mysocket:setpeername('8.8.8.8', "80")
    ip,_ = mysocket:getsockname()
    return ip
end

return {
    -- classes
    sidemenu            = sidemenu,
    -- variables
    home_dir            = home_dir,
    config_dir          = config_dir,
    themes_dir          = themes_dir,
    my_theme            = my_theme,
    terminal            = terminal,
    terminal_cmd        = terminal_cmd,
    editor              = editor,
    editor_cmd          = editor_cmd,
    mpd_remote          = mpd_remote,
    browser             = browser,
    scnd_browser        = scnd_browser,
    mail                = mail,
    mpdclient           = mpdclient,
    image_viewer        = image_viewer,
    pamixer             = pamixer,
    vmixer              = vmixer,
    redshift            = redshift,
    i3lockfancy         = i3lockfancy,
    icon_exec           = icon_exec,
    icon_dir            = icon_dir,
    modkey              = modkey,
    -- functions
    powerset            = powerset,
    async_dummy_cb      = async_dummy_cb,
    os_exec_rv          = os_exec_rv,
    pgrep               = pgrep,
    pkill               = pkill,
    run_once            = run_once,
    start_mail          = start_mail,
    replicate_layout    = replicate_layout,
    set_sidemenu_style  = set_sidemenu_style,
    start_mail_calendar = start_mail_calendar,
    myip                = myip,
    remote_spawn        = amh.util.remote_spawn
}

-- vim:set et sw=4 ts=4 tw=120:

