local utils = require("rc.utils")
local menu_iterator = require("rc.menu_iterator")

-- This array should be set by the user
local hosts = { }

-- Starts synergy on a selected host in the `hosts` array.
local function synergy_on_all_hosts()
    local synergy = require("rc.synergy")
    menu_iterator.iterate(synergy.menu(hosts), 4, synergy.icon)
end

-- starts mpv to play an url on a selected host in the `hosts` array.
local function mpv_multi_host_menu(url)
    local mpv = require("rc.mpv")
    menu_iterator.iterate(mpv.menu(hosts, url), 4, mpv.icon)
end

-- spawn a command on all hosts
local function spawn(cmd, cb, verbose)
    for _,host in pairs(hosts) do
        utils.remote_spawn(host, cmd, cb, verbose)
    end
end

return {
    hosts   = hosts,
    synergy = synergy_on_all_hosts,
    mpv     = mpv_multi_host_menu,
    spawn   = spawn
}

-- vim:set et sw=4 ts=4 tw=120:

