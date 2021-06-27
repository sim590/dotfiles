
package.path =  '/home/simon/.conky/?.lua;' .. ";" .. package.path
local config = require("config")

local my_phone_number = io.popen("gpg -d ~/.conky/voipms/voipms-phone-number"):read("*l")
local cache_path      = "~/.cache/voipcdr.json "
local voipms_path     = "~/.conky/voipms"

conky.config = {
    background             = true,
    update_interval        = 0.5,

    double_buffer          = true,
    no_buffers             = true,
    text_buffer_size       = 2048,

    gap_x                  = 800-config.horiz_margin,
    gap_y                  = 150-config.verti_margin,
    minimum_width          = 500,
    minimum_height         = 200,

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
    default_color          = "C0C0C0",
};

function number_of_calls()
    return tonumber(io.popen("jq '.cdr' "..cache_path.."|jq length"):read("*l")) or 0
end

function jq_voipms_string(index, field)
  return [[${texecpi 5 jq ".cdr[]]..index..[[].]]..field..[[" ]]
         ..cache_path..[[ | tr -d '"\\'}]];
end

function calls()
    local call_table = {}
    for i=0,math.min(2, number_of_calls()-1) do
        local date     = jq_voipms_string(i, "date")
        local callerid = jq_voipms_string(i, "callerid")
        table.insert(call_table,
            "${image "..voipms_path.."/missed-call.png -p 0,"..tostring(i*(16+19)+55).." -s 16x16}"
            .. "${voffset 5}"
            .. "${offset 26}${font DejaVu Sans:size=11:style=normal}" .. callerid .. "${font}"
            .. "\n${voffset -5}"
            .. "${offset 26}${font DejaVu Sans:size=9:italic}" .. date .. "\n"
            )
    end
    return call_table
end

conky.text = [[
${font Aerial:style=Bold:pixelsize=12}VOIP.ms (]]..my_phone_number..[[) ${hr 2}{font}
${font DejaVu Sans:size=11}Appels manqués
${texecpi 30 ]]..voipms_path..[[/voip-cdr}
${font}]] ..
[[${voffset -10}]] ..
table.concat(calls()) .. [[
]];

-- vim: set sts=4 ts=4 sw=4 tw=120 et :

