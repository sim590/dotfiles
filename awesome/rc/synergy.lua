
local utils = require("rc.utils")

-- Starts syenrgyc on synergyc_host and synergys on the this machine. This
-- requires the remote host permits ssh acces to $USER with ssh key.
local function synergy(host)
    utils.remote_spawn(host, 'pkill -u $USER -x synergyc ; synergyc ' ..  utils.myip(),
        function ()
            utils.run_once('synergys')
        end
    )
end

return {
    synergy = synergy
}

-- vim:set et sw=4 ts=4 tw=80:

