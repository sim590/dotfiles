local naughty = require("naughty")
local awful = require("awful")

require("rc.utils")

-- Starts syenrgyc on synergyc_host and synergys on the this machine. This
-- requires the remote host permits ssh acces to $USER with ssh key.
function synergy(host)
    package.path = package.path .. ';' .. config_dir .. '/penlight/lua/?.lua'
    require("pl.stringx").import()

    host = host or 'ultralisk.local'
    local notify_titletext = "Synergy"

    -- {{ little hack to get my ip address
    socket = require("socket")
    mysocket = socket.udp()
    mysocket:setpeername('8.8.8.8', "80")
    myip,_ = mysocket:getsockname()
    -- }}

    -- important not to call synchrouneously as if the main loop takes too much time, awesome has trouble with dbus and
    -- everything freezes.
    awful.spawn.easy_async("avahi-resolve-host-name -4 " .. host,
            function (stdout, stderr, exitreason, exitcode)
                print("avahi appelé")
                -- TODO: checker si l'adresse est déjà IPv4. Si oui, ne pas faire de resolve.
                local host_ip = stdout:split('\t')[2] or ''

                awful.spawn.easy_async(
                        'ssh -o StrictHostKeyChecking=no ' ..  host_ip ..  ' '
                        .. '"pkill -u $USER -x synergyc ; synergyc ' ..  myip .. '"',
                        function(stdout, stderr, exitreason, exitcode)
                            if exitcode == 0 then
                                naughty.notify({
                                    title = notify_titletext,
                                    text  = "Starting synergyc on " .. host .. " (" .. host_ip .. ")" .. "..."
                                })
                                run_once('synergys')
                            else
                                naughty.notify({ preset = naughty.config.presets.critical,
                                    title = notify_titletext,
                                    text  = "Failed to start on remote host \"" .. host .. " (" .. host_ip .. ")" ..
                                            "\"... " .. "exit with code " .. tostring(exitcode)
                                })
                            end
                        end)
            end)
end

