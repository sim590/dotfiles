########################
#  MAIN CONFIGURATION  #
########################

c.session_default_name = "default"

# search engines
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "aur"    : "https://aur.archlinux.org/packages/?K={}",
    "gt"     : "https://translate.google.com/#fr/en/{}",
    "w"      : "https://fr.wikipedia.org/wiki/{}",
    "wen"    : "https://en.wikipedia.org/wiki/{}",
    "aw"     : "https://wiki.archlinux.org/?search={}",
    "cppref" : "http://en.cppreference.com/mwiki/?search={}",
    "yt"     : "https://www.youtube.com/results?search_query={}",
    "gh"     : "https://github.com/search?q={}"
}

##################
#  KEY BINDINGS  #
##################

# general
config.bind(';iy','hint images yank')
# sessions
config.bind('sw', 'set-cmd-text -s :session-save --only-active-window')
config.bind('s',  'session-save default')
# downloads
config.bind('ed', 'download-open')
# videos (mpv, castnow, youtube-dl)
config.bind('x',  'spawn --userscript ~/bin/qutebrowser_bin/mpv')
config.bind(';x', 'hint links spawn mpv --force-window --no-terminal --keep-open=yes --ytdl {hint-url}')
config.bind('xc', 'spawn --userscript ~/bin/qutebrowser_bin/cast {url}')
config.bind(';c', 'hint links spawn --userscript ~/bin/qutebrowser_bin/cast {hint-url}')
config.bind('Yd', 'spawn youtube-dl {url}')
config.bind(';yd','hint links spawn youtube-dl {hint-url}')
config.bind('Ym', 'spawn youtube-dl --extract-audio --audio-format mp3 {url}')
config.bind(';ym','hint links spawn youtube-dl --extract-audio --audio-format mp3 {hint-url}')
# start/stop totally private browsing
config.bind('gp', 'spawn --userscript ~/bin/qutebrowser_bin/totally private')
config.bind('gP', 'spawn --userscript ~/bin/qutebrowser_bin/totally public')
# password fill
config.bind(';p', 'spawn --userscript /home/simon/bin/qutebrowser_bin/password_fill')

# vim:set et sw=4 ts=4 tw=120:

