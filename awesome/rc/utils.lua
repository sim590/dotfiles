local naughty = require("naughty")
local awful = require("awful")
local gears = require("gears")

-- {{{ Variable definitions
-- Setup directories
local home_dir   = os.getenv("HOME")
local config_dir = (home_dir .."/.config/awesome/")
local themes_dir = (config_dir .. "/" .. "themes")
local my_theme   = "powerarrow-darker"

-- This is used later as the default terminal and editor to run.
local terminal     = "urxvt"
local terminal_cmd = terminal .. " -e "
local editor       = os.getenv("EDITOR") or "nvim"
local editor_cmd   = terminal_cmd .. editor
-- TODO: use pass for safely getting password
local mpd_remote   = "env MPD_HOST=q1w2e3r4@/home/simon/.mpd/socket mpc"

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

local function set_one_window_sidemenu_style()
    local t = awful.screen.focused().selected_tag
    t.master_count = 1
    t.master_width_factor = 0.3
    awful.layout.set(awful.layout.suit.tile.left)
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
    set_one_window_sidemenu_style()
end

-- Returns the first valid ip address
local function myip()
    socket = require("socket")
    mysocket = socket.udp()
    mysocket:setpeername('8.8.8.8', "80")
    ip,_ = mysocket:getsockname()
    return ip
end

-- TODO: if host is IPv4 address, don't try to resolve it
-- Runs a command on a remote host. The host is resolved to IPv4 address, then
-- the command is run through SSH protocol.
--  * host: the host on which to run the command
--  * cmd:  the command to spawn
--  * cb:   the callback to run upon success
--
-- Dependencies: {avahi}, {ssh}
local function remote_spawn(host, cmd, cb)
    if not host then return end -- if no host, return
    local remotespawn_label = "Remote Spawn"

    -- important not to call synchrouneously as if the main loop takes too much
    -- time, awesome has trouble with dbus and everything freezes.
    awful.spawn.easy_async("avahi-resolve-host-name -4 " .. host,
        function (stdout, stderr, exitreason, exitcode)
            -- Invalid hostname
            if not exitcode == 0 then
                naughty.notify({
                    preset = naughty.config.presets.critical,
                    title = remotespawn_label,
                    text = "Couldn't resolve host '" .. host .. "'"
                })
            end

            package.path = package.path .. ';' .. config_dir .. '/penlight/lua/?.lua'
            require("pl.stringx").import()
            local host_ip = stdout:split('\t')[2] or ''
            awful.spawn.easy_async('ssh -o StrictHostKeyChecking=no ' .. host_ip
                                    .. ' "env LANG=en_US.UTF-8 DISPLAY=:0 ' .. cmd .. '"',
                function(stdout, stderr, exitreason, exitcode)
                    if exitcode == 0 then
                        naughty.notify({
                            title = remotespawn_label,
                            text  = "Running command '" .. cmd
                                    .. "' on " .. host
                                    .. " (" .. host_ip .. ")" .. "..."
                        })
                        if cb then cb() end
                    else
                        -- Valid hostname, but can't connect through
                        -- SSH to host
                        naughty.notify({ preset = naughty.config.presets.critical,
                            title = remotespawn_label,
                            text  = "Failed to run command on remote host \""
                                    .. host .. " (" .. host_ip .. ")" ..
                                    "\"... " .. "exit with code " .. tostring(exitcode)
                        })
                    end
                end)
        end)
end

return {
    -- variables
    home_dir                      = home_dir,
    config_dir                    = config_dir,
    themes_dir                    = themes_dir,
    my_theme                      = my_theme,
    terminal                      = terminal,
    terminal_cmd                  = terminal_cmd,
    editor                        = editor,
    editor_cmd                    = editor_cmd,
    mpd_remote                    = mpd_remote,
    browser                       = browser,
    scnd_browser                  = scnd_browser,
    mail                          = mail,
    mpdclient                     = mpdclient,
    image_viewer                  = image_viewer,
    pamixer                       = pamixer,
    vmixer                        = vmixer,
    redshift                      = redshift,
    i3lockfancy                   = i3lockfancy,
    icon_exec                     = icon_exec,
    icon_dir                      = icon_dir,
    -- functions
    powerset                      = powerset,
    async_dummy_cb                = async_dummy_cb,
    os_exec_rv                    = os_exec_rv,
    pgrep                         = pgrep,
    pkill                         = pkill,
    run_once                      = run_once,
    start_mail                    = start_mail,
    set_one_window_sidemenu_style = set_one_window_sidemenu_style,
    start_mail_calendar           = start_mail_calendar,
    myip                          = myip,
    remote_spawn                  = remote_spawn
}

-- vim:set et sw=4 ts=4 tw=120:

