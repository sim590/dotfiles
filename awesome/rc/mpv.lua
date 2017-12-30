local awful   = require("awful")

local utils = require("rc.utils")

local icon_path = "/usr/share/icons/hicolor/32x32/apps/mpv.png"
local mpv_cmd   = 'mpv --force-window --no-terminal --keep-open=yes --ytdl'

local function mpv(host, url)
    utils.remote_spawn(host, mpv_cmd .. " '" ..  url .. "'")
end

local function menu(hosts, url)
    local m = {}
    for _,h in pairs(awful.util.table.join(hosts, { "localhost" })) do
        if h == "localhost" then
            m[#m + 1] = {
                "Mpv: " .. h, {
                    function()
                        awful.spawn.easy_async(mpv_cmd .. " '" ..  url .. "'", utils.async_dummy_cb)
                    end
                }
            }
        else
            m[#m + 1] = { "Mpv: " .. h, { function() mpv(h, url) end } }
        end
    end
    return m
end

return {
    icon = icon_path,
    menu = menu,
    mpv  = mpv
}

-- vim:set et sw=4 ts=4 tw=120:

