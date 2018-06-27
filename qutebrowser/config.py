




                     ##########################################################
                     #             Qutebrowser configuration file             #
                     #                                                        #
                     #  Author: Simon Désaulniers (sim.desaulniers@gmail.com) #
                     #                                                        #
                     #                    ,*********....                      #
                     #               ,********.,..**.........                 #
                     #            ,*,*********..................              #
                     #          *.**,******#%%#*.......&&..........           #
                     #        *****&&&&&&&&&&&&&&...&&&&&............         #
                     #       ***&&&&&&&&&&&&&&&&&.&&&&&&&.............        #
                     #     .**&&&&&&&&&&*.&&&&&&&.&&&&&&&...........,**       #
                     #     .,&&&&&&&&.....&&&&&&&.&&&&&&&...........****      #
                     #    ..&&&&&&&.......&&&&&&&.&&&&&...*&&&&&&&*******     #
                     #   ...&&&&&&........&&&&&&&.&&...&&&&&&&&&&&&&&*****    #
                     #   ..*&&&&&&........&&&&&&&..#&&&&&&&&&&&&&&&&&&****    #
                     #   ***&&&&&&........&&&%..&&&&&&&&&/.....,&&&&&&&***    #
                     #   ...&&&&&&...........&&&&&&&&&../.......*&&&&&&***    #
                     #   ...&&&&&&&******%&&&&&&&&&..&&&&........&&&&&&***    #
                     #   ....&&&&&&&&&&&&&&&&&&/..&&&&&&&........&&&&&&**.    #
                     #   .....&&&&&&&&&&&&&&***&&,&&&&&&&.......*&&&&&&...    #
                     #    ......*&&&&&&&***/&&&&&*&&&&&&&.......&&&&&&%..     #
                     #     .....**********&&&&&&&*&&&&&&&.....&&&&&&&&..      #
                     #      .....*********&&&&&&&*&&&&&&&*%&&&&&&&&&&..       #
                     #       .....********&&&&&&&*&&&&&&&&&&&&&&&&&...        #
                     #        .....*******&&&&&***&&&&&&&&&&&&&&.....         #
                     #          ......****&%********/((/,..........           #
                     #             ....*****************........              #
                     #                .*************.........                 #
                     #                                                        #
                     ##########################################################





                                          ###############
                                          #  CONSTANTS  #
                                          ###############

# TOR
TOR_SOCKS_URL  = "socks://127.0.0.1"
TOR_SOCKS_PORT = "9050"
TOR_HOST = TOR_SOCKS_URL+":"+TOR_SOCKS_PORT

mpv_1080p = "mpv --force-window --no-terminal --keep-open=yes --ytdl \
                 --ytdl-format='ytdl-format=bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best'"

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
c.content.headers.accept_language = "fr-CA,fr-FR,fr"

                                         ##################
                                         #  KEY BINDINGS  #
                                         ##################

# general
config.bind('"', 'enter-mode set_mark')
config.bind('0', 'scroll-to-perc -x 0')
config.bind('tg', 'set-cmd-text -s :tab-give')
config.bind('tt', 'set-cmd-text -s :tab-take')
config.unbind('<ctrl-q>', mode='normal')
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
config.bind(';xv', "hint links spawn %s {hint-url}" % mpv_1080p)
config.bind('xc',  'spawn --userscript ~/bin/qutebrowser_bin/cast {url}')
config.bind(';xc', 'hint links spawn --userscript ~/bin/qutebrowser_bin/cast {hint-url}')
## unbinding for preventing shadowing ;Yd and ;Ym
config.unbind(';Y')
dld_msg = ';; message-info "Downloading %s from %s..."'
config.bind('Yd',  'spawn youtube-dl {url}'+ dld_msg % ('video','{url}'))
config.bind(';Yd', 'hint links spawn youtube-dl {hint-url}'+ dld_msg % ('video','{hint-url}'))
config.bind('Ym',  'spawn youtube-dl --extract-audio --audio-format mp3 {url}'
                   + dld_msg % ('audio','{hint}'))
config.bind(';Ym', 'hint links spawn youtube-dl --extract-audio --audio-format mp3 {hint-url}'
                   + dld_msg % ('audio','{hint-url}'))
# start/stop totally private browsing
config.bind('gp',  'set content.proxy %s' % TOR_HOST)
config.bind('gP',  'set content.proxy system')
# password fill
config.bind(';p',  'spawn --userscript ~/bin/qutebrowser_bin/password_fill')

# vim:set et sw=4 ts=4 tw=100:

