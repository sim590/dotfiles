
local unpack = unpack or table.unpack -- 5.1 Lua compatibility

local awful = require("awful")
local naughty = require("naughty")
local utils = require("rc.utils")

local state = { cid = nil }

local function naughty_destroy_callback(reason)
    if reason == naughty.notificationClosedReason.expired or
        reason == naughty.notificationClosedReason.dismissedByUser then
        local actions = state.index and state.menu[state.index - 1][2]
        if actions then
            for _,action in pairs(actions) do
                if action then action() end
            end
            state.index = nil
        end
    end
end

local function iterate(menu, timeout, icon)
    timeout = timeout or 4 -- default timeout for each menu entry
    icon    = icon or nil  -- icon to display on the menu

    -- Build the list of choices
    if not state.index then
        state.menu = menu
        state.index = 1
    end

    -- Select one and display the appropriate notification
    local label, action
    local next  = state.menu[state.index]
    state.index = state.index + 1

    if not next then
        label = "Cancel"
        state.index = nil
    else
        label, _ = unpack(next)
    end
    state.cid = naughty.notify({
        text = label,
        icon = icon,
        timeout = timeout,
        screen = mouse.screen,
        replaces_id = state.cid,
        destroy = naughty_destroy_callback
    }).id
end

return { iterate = iterate }

-- vim:set et sw=4 ts=4 tw=80:

