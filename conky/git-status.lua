
package.path = '/home/simon/.conky/?.lua;' .. ";" .. package.path
local config = require("config")

width  = 500
height = 800

conky.config = {
  background             = true,
  border_inner_margin    = 5,
  border_outer_margin    = 0,
  border_width           = 2,
  gap_x                  = 800-config.horiz_margin,
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
  font                   = "DejaVu Sans:size=11",
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

${font Aerial:style=Bold:pixelsize=12}GIT STATUS ${hr 2}${font}
${execpi 20 conky-git-status.sh}

]]
