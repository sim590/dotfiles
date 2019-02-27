
package.path =  '/home/simon/.conky/?.lua;' .. ";" .. package.path
local config = require("config")

local task_cache_path = "~/.cache/conky-tasks.json"

conky.config = {
    background             = true,
    update_interval        = 1,

    double_buffer          = true,
    no_buffers             = true,
    text_buffer_size       = 2048,

    gap_x                  = 150,
    gap_y                  = 50,
    minimum_width          = 500,

    own_window             = true,
    own_window_type        = 'override',
    own_window_transparent = false,
    own_window_argb_value  = 0,
    own_window_argb_visual = true,
    own_window_class       = 'conky-semi',
    own_window_hints       = 'undecorated,sticky,skip_taskbar,skip_pager,below',

    border_inner_margin    = 0,
    border_outer_margin    = 0,
    alignment              = 'bl',

    draw_shades            = false,
    draw_outline           = false,
    draw_borders           = false,
    draw_graph_borders     = false,

    override_utf8_locale   = true,
    use_xft                = true,
    font                   = 'caviar dreams:size=11',
    xftalpha               = 0.5,
    uppercase              = false,

    -- Defining colors
    default_color          = config.white,
    color1                 = config.grey1,
    color2                 = config.grey2,
    color3                 = config.grey3,
    color4                 = config.orange,
    color5                 = config.green,
};

-- TODO: Passer à json-lua (installer et documenter la dépendance). Ainsi, il
-- sera possible d'itérer à travers la liste d'éléments sous forme d'un
-- tableau...

-- TODO: récupérer les tâches et les formater
local tasks = {}
for i=0,math.min(2, number_of_calls()-1) do
    local date     = jq_voipms_string(i, "date")
    local callerid = jq_voipms_string(i, "callerid")
    table.insert(tasks,
        "${font Ubuntu:size=18:style=normal}${color1}" .. callerid
        .. "\n${voffset -10}"
        .. "${offset 42}${font Ubuntu:size=11:italic}${color3}" .. date .. "\n"
        )
end

conky.text = [[
${color4}${font Ubuntu:size=16:style=bold}TÂCHES ${hr 2}
${execi 15 task export >]]..task_cache_path..[[}
]];

-- vim: set sts=4 ts=4 sw=4 tw=120 et :

