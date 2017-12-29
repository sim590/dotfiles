local awful   = require("awful")

local utils = require("rc.utils")

local icon_path = "/home/simon/.local/share/icons/hicolor/48x48/apps/synergy.png"

-- Starts syenrgyc on synergyc_host and synergys on the this machine. This
-- requires the remote host permits ssh acces to $USER with ssh key.
local function synergy(host)
    utils.remote_spawn(host, 'pkill -u $USER -x synergyc ; synergyc ' ..  utils.myip(),
        function ()
            utils.run_once('synergys')
        end
    )
end

local function menu(hosts)
    local m = {}
    local h_combinations = utils.powerset(hosts)
    for _,c in pairs(h_combinations) do
        if #c > 0 then
            local cbs = {}
            for _,h in pairs(c) do
                cbs[#cbs + 1] = function() synergy(h) end
            end
            for _,h in pairs(hosts) do
                if not awful.util.table.hasitem(c, h) then
                    cbs[#cbs + 1] = function() utils.remote_spawn(h, "pkill -u $USER -x synergyc") end
                end
            end

            m[#m + 1] = { "Synergy: " .. table.concat(c, " + "), cbs }
        end
    end
    return m
end

return {
    icon    = icon_path,
    menu    = menu,
    synergy = synergy
}

-- vim:set et sw=4 ts=4 tw=80:

