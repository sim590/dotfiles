########################
#  MAIN CONFIGURATION  #
########################

c.session.default_name = "default"

# search engines
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "aur"    : "https://aur.archlinux.org/packages/?K={}",
    "g"      : "https://encrypted.google.com/search?hl=fr&q={}",
    "fr"     : "http://www.larousse.fr/dictionnaires/francais/{}",
    "gt"     : "https://translate.google.com/#fr/en/{}",
    "gi"     : "https://www.google.ca/search?tbm=isch&q={}&tbs=imgo:1&gws_rd=cr&dcr=0&ei=AKXuWfTQOIK0jgTNkYagDg",
    "gm"     : "https://www.google.ca/maps?hl=fr&q={}",
    "w"      : "https://fr.wikipedia.org/wiki/{}",
    "wen"    : "https://en.wikipedia.org/wiki/{}",
    "aw"     : "https://wiki.archlinux.org/?search={}",
    "cppref" : "http://en.cppreference.com/mwiki/?search={}",
    "yt"     : "https://www.youtube.com/results?search_query={}",
    "gh"     : "https://github.com/search?q={}",
    "imdb"   : "http://www.imdb.com/find?s=all&q={}"
}

c.spellcheck.languages = ["fr-FR", "en-CA"]

##################
#  KEY BINDINGS  #
##################

# general
config.bind('"', 'enter-mode set_mark')
config.bind('0', 'scroll-to-perc -x 0')
## passthrough allow ctrl-v for pasting clipboard
config.unbind('<ctrl-v>', mode='passthrough')
config.bind('<ctrl-d>','leave-mode', mode='passthrough')
config.bind(';iy', 'hint images yank')
# sessions
config.bind('sw',  'set-cmd-text -s :session-save --only-active-window')
config.bind('ss',  'session-save default')
# downloads
config.bind('ed',  'download-open')
# videos (mpv, castnow, youtube-dl)
config.bind('xv',  'spawn --userscript ~/bin/qutebrowser_bin/mpv')
config.bind(';xv', 'hint links spawn mpv --force-window --no-terminal --keep-open=yes --ytdl {hint-url}')
config.bind('xc',  'spawn --userscript ~/bin/qutebrowser_bin/cast {url}')
config.bind(';xc', 'hint links spawn --userscript ~/bin/qutebrowser_bin/cast {hint-url}')
## unbinding for preventing shadowing ;Yd and ;Ym
config.unbind(';Y')
config.bind('Yd',  'spawn youtube-dl {url}')
config.bind(';Yd', 'hint links spawn youtube-dl {hint-url}')
config.bind('Ym',  'spawn youtube-dl --extract-audio --audio-format mp3 {url}')
config.bind(';Ym', 'hint links spawn youtube-dl --extract-audio --audio-format mp3 {hint-url}')
# start/stop totally private browsing
config.bind('gp',  'spawn --userscript ~/bin/qutebrowser_bin/totally private')
config.bind('gP',  'spawn --userscript ~/bin/qutebrowser_bin/totally public')
# password fill
config.bind(';p',  'spawn --userscript /home/simon/bin/qutebrowser_bin/password_fill')

# vim:set et sw=4 ts=4 tw=120:

