local utils = require("rc.utils")

-- This array should be set by the user
local hosts = { }

-- Starts synergy on all hosts in the `hosts` array.
local function synergy_on_all_hosts()
    local synergy = require("rc.synergy")
    local menu_iterator = require("rc.menu_iterator")
    menu_iterator.iterate(synergy.menu(hosts), 4, synergy.icon)
end

-- spawn a command on all hosts
local function spawn(cmd, cb)
    for _,host in pairs(hosts) do
        utils.remote_spawn(host, cmd, cb)
    end
end

return {
    hosts   = hosts,
    synergy = synergy_on_all_hosts,
    spawn   = spawn
}

-- vim:set et sw=4 ts=4 tw=120:

