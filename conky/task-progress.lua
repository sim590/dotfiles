
package.path = '/home/simon/.conky/?.lua;' .. ";" .. package.path
local config = require("config")

width  = 700
height = 1080

conky.config = {
  background             = true,
  border_inner_margin    = 5,
  border_outer_margin    = 0,
  border_width           = 2,
  gap_x                  = config.horiz_margin,
  gap_y                  = 1080-height-config.verti_margin,
  default_bar_height     = 5,
  default_bar_width      = 80,
  default_color          = "C0C0C0",
  default_graph_height   = 25,
  default_graph_width    = 200,
  default_outline_color  = "000000",
  default_shade_color    = "000000",
  double_buffer          = true,
  draw_borders           = false,
  draw_graph_borders     = false,
  draw_outline           = false,
  draw_shades            = false,
  font                   = "DejaVu Sans Mono:size=10",
  minimum_height         = height,
  maximum_width          = width,
  minimum_width          = width,
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
  total_run_times        = 0,
  update_interval        = 5,
  uppercase              = false,
  use_spacer             = "none",
  use_xft                = true,
  xftalpha               = 0.8,
};

conky.text=[[

${font Aerial:style=Bold:pixelsize=12}EN COURS ${hr 2}${font}
${texecpi 5 flock /home/simon/.task task limit:10 rc.defaultwidth:100 rc._forcecolor:on rc.verbose:affected,blank doing | ansito - | sed -r 's/([^ ])#/\1\\#/g'}

${font Aerial:style=Bold:pixelsize=12}À FAIRE ${hr 2}${font}
${texecpi 5 flock /home/simon/.task task limit:10 rc.defaultwidth:100 rc._forcecolor:on rc.verbose:affected,blank todo | ansito - | sed -r 's/([^ ])#/\1\\#/g' }

${font Aerial:style=Bold:pixelsize=12}BURNDOWN ${hr 2}${font}

${font FreeMono:style=Bold:size=10}${texecpi 120 flock /home/simon/.task task rc._forcecolor:on -WAITING burndown.monthly | tail -n+2 | head -n-2 | conky-bg-space-to-fg.sh | ansito - | sed -r 's/([^ ])#/\1\\#/g'}${font}

${font Aerial:style=Bold:pixelsize=12}ÉTAT DES PROJETS ${hr 2}${font}
${font DejaVu Sans:size=11}${texecpi 180 flock /home/simon/.task conky-task-progress.sh}${font}

]]
