local naughty = require("naughty")

require("rc.utils")

-- Starts syenrgyc on synergyc_host and synergys on the this machine. This
-- requires the remote host permits ssh acces to $USER with ssh key.
function synergy(host)
    package.path = package.path .. ';' .. config_dir .. '/penlight/lua/?.lua'
    --TODO: use spawn.system(...) when luarocks is setup
    -- package.path = package.path .. ';' .. config_dir .. '/lua-spawn/?/init.lua'
    -- package.path = package.path .. ';' .. config_dir .. '/lua-spawn/?.lua'
    -- package.cpath = package.cpath .. ';' .. config_dir .. '/lua-spawn/?.so'
    require("pl.stringx").import()
    --TODO: use spawn.system(...) when luarocks is setup
    -- local spawn = require("spawn")

    host = host or 'ultralisk.local'
    local notify_titletext = "Synergy"

    -- {{ little hack to get my ip address
    socket = require("socket")
    mysocket = socket.udp()
    mysocket:setpeername('8.8.8.8', "80")
    myip,_ = mysocket:getsockname()
    -- }}

    -- resolve avahi hostname to ipv4 address
    resolver = io.popen("avahi-resolve-host-name -4 " .. host)
    host_ip = resolver:read("*l"):split('\t')[2]
    resolver:close()

    --restarting synergyc on the remote host before starting synergy server.
    --TODO: use spawn.system(...) when luarocks is setup
    local ret = os.execute('ssh -o StrictHostKeyChecking=no ' ..  host_ip ..  ' '
                            .. '"pkill -u $USER -x synergyc ; synergyc ' ..  myip .. '"')
    -- FIXME: Lua5.1 SUCKS. Use spawn.system(...) when luarocks is setup
    local version = tonumber(_VERSION:split(' ')[2])
    if version == 5.1 then
        synergized = ret
    elseif version > 5.1 then
        synergized = ret[3]
    else
        naughty.notify({ preset = naughty.config.presets.critical,
            title = notify_titletext,
            text  = "What is this lua version? Get outta here!"
        })
    end

    if synergized == 0 then
        naughty.notify({
            title = notify_titletext,
            text  = "Starting synergyc on " .. host .. " (" .. host_ip .. ")" .. "..."
        })
        run_once('synergys')
    else
        naughty.notify({ preset = naughty.config.presets.critical,
            title = notify_titletext,
            text  = "Failed to start on remote host \"" .. host .. " (" .. host_ip .. ")" .. "\"... "
                    .. "exit with code " .. tostring(synergized)
        })
    end
end

