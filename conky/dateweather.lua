package.path =  '/home/simon/.conky/?.lua;' .. ";" .. package.path
local config = require("config")

local weather_dir   = "~/.conky/dateweather"
local imgs_dir      = weather_dir .. "/imgs"
local parse_weather = weather_dir .. "/parse_weather"
local get_weather   = weather_dir .. "/get_weather"

local vision_cache_dir_path   = "~/.cache/conky-vision/"
local weather_cache_path      = "~/.cache/conky-vision/weather.json"
local forecast_cache_dir_path = "~/.cache/conky-vision/forecast"

-- TODO: lire depuis un fichier en clair
local api_key = io.popen("gpg -d ~/.conky/dateweather/openweathermap.api.key"):read("*l")

conky.config = {
    -------------------------------------
    --  Generic Settings
    -------------------------------------
    background=true,
    update_interval=1,
    double_buffer=true,
    no_buffers=true,
    imlib_cache_size=0,

    draw_shades=false,
    draw_outline=false,
    draw_borders=false,
    -- FIXME: ajouter la ligne suivante ou non corrige ou pas l'affichage dans
    -- le bon écran. Y'a un bug où le conky s'affiche dans le mauvais écran...
    xinerama_head = 2,

    -------------------------------------
    --  Window Specifications
    -------------------------------------
    gap_x=100,
    gap_y=150,

    alignment="tl",

    minimum_height=400,
    minimum_width=600,

    own_window=true,
    own_window_type="override",
    own_window_transparent=true,
    own_window_hints="undecorated,below,sticky,skip_taskbar,skip_pager",

    own_window_argb_visual=true,
    own_window_argb_value=0,

    -------------------------------------
    --  Text Settings
    -------------------------------------
    use_xft=true,
    xftalpha=1,
    font="Droid Sans:size=10",
    text_buffer_size=256,
    override_utf8_locale=true,

    -------------------------------------
    --  Color Scheme
    -------------------------------------
    default_color='FFFFFF',

    color0=config.white, -- clock
    color1=config.grey3,  -- date
    color2=config.green, -- current temperature
    color3=config.grey1,  -- high tempratures
    color4=config.grey3,  -- low tempratures
    color5='FFFFFF',      -- days

    -------------------------------------
    --  Icon Sources
    -------------------------------------
    template0 = imgs_dir,  --  today
    template1 = imgs_dir,  --  +1day
    template2 = imgs_dir,  --  +2days
    template3 = imgs_dir,  --  +3days
    template4 = imgs_dir,  --  +4days

    -------------------------------------
    --  API Key
    -------------------------------------
    template6=api_key,

    -------------------------------------
    --  City ID
    -------------------------------------
    template7="6077243",

    -------------------------------------
    --  Temp Unit (default, metric, imperial)
    -------------------------------------
    template8="metric",

    -------------------------------------
    --  Locale (e.g. "es_ES.UTF-8")
    --  Leave empty for default
    -------------------------------------
    template9="eo.UTF-8"
}

conky.text = [[
\
${execi 300 ]] .. get_weather .. [[ ${template6} ${template7} ${template8} ${template9}}\
\
${font Poiret One:weight=Light:size=96}${color0}\
${alignc}${time %H:%M}\
${font}${color}
\
${font Poiret One:weight=Light:size=28}${color1}\
${voffset 30}\
${alignc}${execi 300 LANG=${template9} LC_TIME=${template9} date +"%A, %d %B"}\
${font}${color}
]]

-- vim: set sts=4 ts=4 sw=4 tw=120 et :

