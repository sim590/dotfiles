




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




                                           ##############
                                           #  SETTINGS  #
                                           ##############

c.auto_save.session = True
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

for urlpattern in (
        '*://www.google.com/maps/*',
        '*://translate.google.com',
        '*://hoogle.haskell.org',
        '*://www.laparlure.com',
        '*://facebook.com'):
    opt = 'input.insert_mode.leave_on_load'
    config.set(opt, False, urlpattern)
    config.set(opt, False, urlpattern.replace('.com', '.ca'))

# vim:set et sw=4 ts=4 tw=100:

