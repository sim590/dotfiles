
package.path = package.path .. ";/home/simon/prog/split-monitor-workspaces/lua/?.lua"
local smw    = require("split-monitor-workspaces")

smw.setup({
    workspace_count              = 10,
    monitor_priority             = { "DP-1", "DP-2" },
    keep_focused                 = true,
    enable_persistent_workspaces = false,
})

