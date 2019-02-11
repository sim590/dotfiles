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

    -------------------------------------
    --  Window Specifications
    -------------------------------------
    gap_x=0,
    gap_y=0,

    alignment="bl",

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

    color0='FFFFFF', -- clock
    color1='FFFFFF', -- date
    color2='FFFFFF', -- current temperature
    color3='FFFFFF', -- high tempratures
    color4='FFFFFF', -- low tempratures
    color5='FFFFFF', -- days

    -------------------------------------
    --  Icon Sources
    -------------------------------------
    template0='~/.conky/dateweather/imgs',  --  today
    template1='~/.conky/dateweather/imgs',  --  +1day
    template2='~/.conky/dateweather/imgs',  --  +2days
    template3='~/.conky/dateweather/imgs',  --  +3days
    template4='~/.conky/dateweather/imgs',  --  +4days

    -------------------------------------
    --  API Key
    -------------------------------------
    template6="679f2aabf32fb7e3e854b5a3192152ce",

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
    template9="fr_CA.UTF-8"
}

conky.text = [[
\
${execi 300 ~/.conky/dateweather/get_weather ${template6} ${template7} ${template8} ${template9}}\
\
${font Poiret One:weight=Light:size=96}${color0}\
${alignc}${time %H:%M}\
${font}${color}
\
${font Poiret One:weight=Light:size=28}${color1}\
${voffset 30}\
${alignc}${execi 300 LANG=${template9} LC_TIME=${template9} date +"%A, %B %d"}\
${font}${color}
\
${font Poiret One:size=18}${color2}\
${voffset 36}\
${goto 60}${execi 300 jq .main.temp ~/.cache/conky-vision/weather.json | awk '{print int($1+0.5)}' # round num}°\
${font}${color}\
\
${font Poiret One:size=12}${color3}\
${goto 164}${execi 300 ~/.conky/dateweather/parse_weather 'max' '.main.temp' '1'}°\
${goto 272}${execi 300 ~/.conky/dateweather/parse_weather 'max' '.main.temp' '2'}°\
${goto 378}${execi 300 ~/.conky/dateweather/parse_weather 'max' '.main.temp' '3'}°\
${goto 484}${execi 300 ~/.conky/dateweather/parse_weather 'max' '.main.temp' '4'}°\
${font}${color}\
\
${font Poiret One:size=12}${color4}\
${voffset 52}\
${goto 218}${execi 300 ~/.conky/dateweather/parse_weather 'min' '.main.temp' '1'}°\
${goto 324}${execi 300 ~/.conky/dateweather/parse_weather 'min' '.main.temp' '2'}°\
${goto 430}${execi 300 ~/.conky/dateweather/parse_weather 'min' '.main.temp' '3'}°\
${goto 536}${execi 300 ~/.conky/dateweather/parse_weather 'min' '.main.temp' '4'}°\
${font}${color}
\
${font Poiret One:size=14}${color5}\
${voffset 20}\
${goto 76}${execi 300 LANG=${template9} LC_TIME=${template9} date +%^a}\
${goto 182}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +1day +%^a}\
${goto 288}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +2days +%^a}\
${goto 394}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +3days +%^a}\
${goto 500}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +4days +%^a}\
${font}${color}
\
${execi 300 cp -f ${template0}/$(jq .weather[0].id ~/.cache/conky-vision/weather.json).png ~/.cache/conky-vision/current.png}${image ~/.cache/conky-vision/current.png -p 72,266 -s 32x32}\
${execi 300 cp -f ${template1}/$(~/.conky/dateweather/parse_weather 'first' '.weather[0].id' '1').png ~/.cache/conky-vision/forecast-1.png}${image ~/.cache/conky-vision/forecast-1.png -p 178,266 -s 32x32}\
${execi 300 cp -f ${template2}/$(~/.conky/dateweather/parse_weather 'first' '.weather[0].id' '2').png ~/.cache/conky-vision/forecast-2.png}${image ~/.cache/conky-vision/forecast-2.png -p 284,266 -s 32x32}\
${execi 300 cp -f ${template3}/$(~/.conky/dateweather/parse_weather 'first' '.weather[0].id' '3').png ~/.cache/conky-vision/forecast-3.png}${image ~/.cache/conky-vision/forecast-3.png -p 390,266 -s 32x32}\
${execi 300 cp -f ${template4}/$(~/.conky/dateweather/parse_weather 'first' '.weather[0].id' '4').png ~/.cache/conky-vision/forecast-4.png}${image ~/.cache/conky-vision/forecast-4.png -p 496,266 -s 32x32}\
]]
