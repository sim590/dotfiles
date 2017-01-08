local naughty = require("naughty")

-- Starts syenrgyc on synergyc_host and synergys on the this machine. This
-- requires the remote host permits ssh acces to $USER with ssh key.
function synergy(host)
    if not host then host = 'ultralisk.local' end

    -- {{ little hack to get my ip address
    socket = require("socket")
    mysocket = socket.udp()
    mysocket:setpeername('8.8.8.8', "80")
    myip,_ = mysocket:getsockname()
    -- }}

    --restarting synergyc on the remote host before starting synergy server.
    synergy_call = 'ssh -o StrictHostKeyChecking=no ' ..  host ..
        ' ' .. '"pkill -u $USER -x synergyc ; synergyc ' ..  myip .. '"'
    j = 0
    local synergied
    repeat
        synergied = {io.popen(synergy_call):close()}
        j = j + 1

        -- wait a second
        t0 = os.clock()
        while os.clock() - t0 <= 1 do end
    until synergied[1] or j == 2 -- this let ssh/avahi a chance to resolve the host.

    if synergied[1] then
        notify_text = "Starting synergyc on " .. host .. "..."
        run_once('synergys')
    else
        notify_text = "Failed to connect to remote host \"" .. host .. "\"..."
    end
    naughty.notify({
        title = "Synergy",
        text  = notify_text
    })
end
