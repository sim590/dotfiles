# dotfiles

## Content

The list of included files follows :

    .
    ├── awesome
    │   ├── Makefile
    │   ├── rc
    │   │   ├── auto.lua
    │   │   ├── conky.lua
    │   │   ├── keys.lua
    │   │   ├── rules.lua
    │   │   ├── synergy.lua
    │   │   ├── utils.lua
    │   │   ├── widgets.lua
    │   │   └── xrandr.lua
    │   └── rc.lua
    ├── gitconfig
    ├── gitconfig.orig
    ├── Makefile
    ├── qutebrowser
    │   ├── keys.conf
    │   ├── Makefile
    │   └── qutebrowser.conf
    ├── README.md
    ├── todo.txt
    ├── vim
    │   ├── after
    │   │   ├── ftplugin
    │   │   └── plugin
    │   │       └── abolish.vim
    │   ├── functions.vim
    │   ├── Makefile
    │   ├── mappings.vim
    │   ├── plugins-config
    │   │   ├── ack.vim
    │   │   ├── clang_complete.vim
    │   │   ├── dragvisuals.vim
    │   │   ├── DrawIt.vim
    │   │   ├── fugitive.vim
    │   │   ├── fuzzyfinder.vim
    │   │   ├── gundo.vim
    │   │   ├── jedi-vim.vim
    │   │   ├── listtrans.vim
    │   │   ├── markdown.vim
    │   │   ├── NERDCommenter.vim
    │   │   ├── omnicpp.vim
    │   │   ├── pi_netrw.vim
    │   │   ├── pyclewn.vim
    │   │   ├── python-mode.vim
    │   │   ├── quicklink.vim
    │   │   ├── quicktask.vim
    │   │   ├── rsi.vim
    │   │   ├── sexp.vim
    │   │   ├── snipMate.vim
    │   │   ├── syntastic.vim
    │   │   ├── taglist.vim
    │   │   ├── ultisnips.vim
    │   │   ├── vim-clang.vim
    │   │   ├── vim-multi-cursor.vim
    │   │   ├── vundle.vim
    │   │   └── youcompleteme.vim
    │   └── syntax
    │       ├── cs.vim
    │       └── pyrex.vim
    └── vimrc

    9 directories, 52 files

## Install

The Makefiles assist you in installing this configuration. *The installation process actually creates symlinks in relevant directories for each program*. **Those symlinks replace your configuration files in your system.**

Installing, you simply do:

```sh
make
```

You may have to clean the files already present on your system. Then, you do as
follows:
```sh
make clean && make
```
