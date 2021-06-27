
package.path = '/home/simon/.conky/?.lua;' .. ";" .. package.path
local config = require("config")

width  = 550
height = 1000

conky.config = {
  background             = true,
  border_inner_margin    = 5,
  border_outer_margin    = 0,
  border_width           = 2,
  gap_x                  = 1920-width-config.horiz_margin,
  gap_y                  = 1080-height-config.verti_margin,
  cpu_avg_samples        = 2,
  default_bar_height     = 5,
  default_bar_width      = 80,
  default_color          = "C0C0C0",
  default_graph_height   = 25,
  default_graph_width    = 200,
  default_outline_color  = "000000",
  default_shade_color    = "000000",
  diskio_avg_samples     = 2,
  double_buffer          = true,
  draw_borders           = false,
  draw_graph_borders     = false,
  draw_outline           = false,
  draw_shades            = false,
  font                   = "DejaVu Sans:size=11",
  minimum_height         = height,
  maximum_width          = width,
  minimum_width          = width,
  net_avg_samples        = 2,
  no_buffers             = true,
  override_utf8_locale   = true,
  own_window_class       = "conky",
  own_window_hints       = "undecorated,below,skip_taskbar,skip_pager,sticky",
  own_window_transparent = true,
  own_window             = true,
  own_window_type        = "override",
  own_window_argb_visual = true,
  stippled_borders       = 0,
  text_buffer_size       = 6144,
  top_cpu_separate       = true,
  top_name_width         = 25,
  total_run_times        = 0,
  update_interval        = 5,
  uppercase              = false,
  use_spacer             = "none",
  use_xft                = true,
  xftalpha               = 0.8,

  --Network Template
  template3=[[${if_up \1}${font}\1 down: ${downspeed \1} (${totaldown \1}) ${alignr}up: ${upspeed \1} (${totalup \1})\n${font}${downspeedgraph \1 25,140 C0C0C0 5F9EA0 -t} ${alignr}${upspeedgraph \1 25,140 C0C0C0 5F9EA0 -t}\n${endif}]]


};

conky.text=[[

${font Aerial:style=Bold:pixelsize=12}SYSTÈME ${hr 2}${font}
${font}${alignr}${cpugraph cpu0 40,550 C0C0C0 5F9EA0 -t}
${font} CPU01${tab}${cpubar cpu1 5,80} ${cpu cpu1}%  ${hwmon 0 temp 1}°C ${goto 250}${font} CPU02${tab}${cpubar cpu2 5,80} ${cpu cpu2}%  ${hwmon 0 temp 2}°C
${font} CPU03${tab}${cpubar cpu3 5,80} ${cpu cpu3}%  ${hwmon 1 temp 1}°C ${goto 250}${font} CPU04${tab}${cpubar cpu4 5,80} ${cpu cpu4}%  ${hwmon 1 temp 2}°C
${font} CPU05${tab}${cpubar cpu5 5,80} ${cpu cpu5}%  ${hwmon 1 temp 3}°C ${goto 250}${font} CPU06${tab}${cpubar cpu6 5,80} ${cpu cpu6}%  ${hwmon 2 temp 1}°C
${font} CPU07${tab}${cpubar cpu7 5,80} ${cpu cpu7}%  ${hwmon 2 temp 2}°C ${goto 250}${font} CPU08${tab}${cpubar cpu8 5,80} ${cpu cpu8}%  ${hwmon 2 temp 3}°C
${font} CPU09${tab}${cpubar cpu9 5,80} ${cpu cpu9}%  ${hwmon 3 temp 1}°C ${goto 250}${font} CPU10${tab}${cpubar cpu10 5,80} ${cpu cpu10}%  ${hwmon 3 temp 2}°C
${font} CPU11${tab}${cpubar cpu11 5,80} ${cpu cpu11}%  ${hwmon 3 temp 3}°C ${goto 250}${font} CPU12${tab}${cpubar cpu12 5,80} ${cpu cpu12}%  ${hwmon 3 temp 4}°C

${font}${alignr}${memgraph 10,550 C0C0C0 5F9EA0 -t}
${font} RAM${tab}${membar 10,400} ${memperc}%  ${mem}

${font Aerial:style=Bold:pixelsize=12}UTILISATION DES DISQUES ${hr 2}${font}
${texecpi 120 conky-diskio.sh}
${texecpi 120 conky-disk-usage.sh}

${font Aerial:style=Bold:pixelsize=12}RÉSEAU ${hr 2}${font}
${font}${alignr}Local IP address: ${addr enp7s0}
${template3 enp7s0}\

${font Aerial:style=Bold:pixelsize=12}PROCESSUS ${hr 2}${font}
${top_cpu_separate=false}NOM ${alignr}PID    CPU   MEM
${top name 1} ${alignr}${top pid 1} ${top cpu 1} ${top mem 1}
${top name 2} ${alignr}${top pid 2} ${top cpu 2} ${top mem 2}
${top name 3} ${alignr}${top pid 3} ${top cpu 3} ${top mem 3}
${top name 4} ${alignr}${top pid 4} ${top cpu 4} ${top mem 4}
${top name 5} ${alignr}${top pid 5} ${top cpu 5} ${top mem 5}

${font Aerial:style=Bold:pixelsize=12}GROS FICHIERS ${hr 2}${font}
${texecpi 30 conky-biggest-files.sh ~}

${font Aerial:style=Bold:pixelsize=12}UTILISATION DES RÉPERTOIRES ${hr 2}${font}
${texecpi 30 conky-directory-usage.sh ~}
]]
