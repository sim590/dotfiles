




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





# Chains commands one after the other to a same key.
def bind_chained(config, key, *commands):
    config.bind(key, ' ;; '.join(commands))

#  vim: set sts=4 ts=8 sw=4 tw=120 et :

