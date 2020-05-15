




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





# general
config.unbind('<ctrl-x>')
config.unbind('<ctrl-a>')
config.bind('g-', 'navigate decrement')
config.bind('g+', 'navigate increment')

# Rapid links
config.unbind(';r')
config.bind(';ra', ':hint --rapid all tab-bg')
config.bind(';rr', ':hint --rapid links tab-bg')
config.bind(';rd', ':hint --rapid links download')

config.bind('"', 'enter-mode set_mark')
config.bind('0', 'scroll-to-perc -x 0')
config.bind('tg', 'set-cmd-text -s :tab-give')
config.bind('tG', 'spawn --userscript ~/bin/qutebrowser_bin/qurlshare {url}')
config.bind('tt', 'set-cmd-text -s :tab-take')
config.bind('tT', 'spawn --userscript ~/bin/qutebrowser_bin/qurlshare -g')
config.unbind('<ctrl-q>', mode='normal')
## passthrough allow ctrl-v for pasting clipboard
config.bind('<ctrl-d>','leave-mode', mode='passthrough')
config.bind(';iy', 'hint images yank')
# sessions
config.bind('sw',  'set-cmd-text -s :session-save --only-active-window')
config.bind('sL',  'set-cmd-text -s :session-load')
config.bind('ss',  'session-save default')
# downloads
config.bind('ed',  'download-open')
# videos (mpv, castnow, youtube-dl)
config.bind('xv',  'spawn --userscript ~/bin/qutebrowser_bin/mpv')

config.bind(';xv', "hint links spawn %s {hint-url}"
             % "mpv --force-window --no-terminal --keep-open=yes --ytdl "
               "--ytdl-format="
               "'ytdl-format=bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best'")
config.bind('xc',  'spawn --userscript ~/bin/qutebrowser_bin/cast {url}')
config.bind(';xc', 'hint links spawn --userscript ~/bin/qutebrowser_bin/cast {hint-url}')
## unbinding for preventing shadowing ;Yd and ;Ym
config.unbind(';Y')
dld_msg = ';; message-info "Downloading %s from %s..."'
config.bind('Yd',  'spawn youtube-dl {url}'+ dld_msg % ('video','{url}'))
config.bind(';Yd', 'hint links spawn youtube-dl {hint-url}'+ dld_msg % ('video','{hint-url}'))
config.bind('Ym',  'spawn youtube-dl --extract-audio --audio-format mp3 {url}'
                   + dld_msg % ('audio','{url}'))
config.bind(';Ym', 'hint links spawn youtube-dl --extract-audio --audio-format mp3 {hint-url}'
                   + dld_msg % ('audio','{hint-url}'))
# password fill
config.bind(';p',  'spawn --userscript ~/bin/qutebrowser_bin/password_fill')

#  vim: set sts=4 ts=8 sw=4 tw=100 et :

