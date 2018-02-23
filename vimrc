" PLUGIN CONFIGURATION =============================
call plug#begin('~/.vim/plugged')
Plug 'L9'
" Colors ============================
Plug 'michalbachowski/vim-wombat256mod'
Plug 'crusoexia/vim-monokai'
Plug 'preocanin/greenwint'
Plug 'prognostic/plasticine'
"====================================
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
"snippets --------------------
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"-----------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'searchfold.vim'
Plug 'godlygeek/tabular' "Must load before vim-markdown (see :h vim-markdown)
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'ack.vim'
Plug 'taglist.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'plasticboy/vim-markdown'
Plug 'DrawIt'
Plug 'tpope/vim-rsi', 'no_meta_opts'
Plug 'tpope/vim-unimpaired'
Plug 'atweiden/vim-dragvisuals'
Plug 'sim590/vim-listtrans'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
" tpop/vim-eunuch -----------------------
Plug 'tpope/vim-eunuch', { 'frozen': 1 }
Plug 'tpope/vim-eunuch', 'RmSwp-command'
"----------------------------------------
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', { 'do' : './install.py --system-libclang --clang-completer --cs-completer' }
Plug 'rdnetto/YCM-Generator', 'stable'
Plug 'Xe/lolcode.vim'
Plug 'aaronbieber/vim-quicktask'
Plug 'TaskList.vim'
Plug 'mhinz/vim-startify'
Plug 'Raimondi/delimitMate'
" vim-radical & dependencies --- "TODO: Check pourquoi ça load pas??
Plug 'glts/vim-radical'
Plug 'google/vim-maktaba'
Plug 'glts/vim-magnum'
" ------------------------------
Plug 'vim-auto-save', 'noautocmd'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
if ! has('gui_running')
  Plug 'floobits/floobits-neovim'
endif
Plug 'jamessan/vim-gnupg'
Plug 'tomlion/vim-solidity'
Plug 'eagletmt/neco-ghc'

call plug#end()

filetype plugin indent on
syntax on

let mapleader=","
let g:programming_fts = [
      \ "c",
      \ "cpp",
      \ "python",
      \ "pyrex",
      \ "haskell",
      \ "lua",
      \ "php",
      \ "js",
      \ "html",
      \ "css",
      \ "cs",
      \ "java",
      \ "sh"
      \ ]
let g:syntaxed_fts = g:programming_fts + [
      \ "vim",
      \ "tex",
      \ "markdown",
      \ "rst",
      \ "cmake",
      \ "make"
      \ ]

" OTHER FILES ===================
source ~/.vim/options.vim
source ~/.vim/abbreviations.vim
source ~/.vim/utilities.vim
source ~/.vim/mappings.vim
" ===============================

" COLORSCHEME ==========
MyColorscheme wombat256mod
" ======================

" PLUGIN SETTINGS ==================================
let s:settings_dir="~/.vim/plugins-config/"
let s:configs = [
      \ "taglist.vim",
      \ "rsi.vim",
      \ "pyclewn.vim",
      \ "vim-multi-cursor.vim",
      \ "ack.vim",
      \ "fugitive.vim",
      \ "snipMate.vim",
      \ "ultisnips.vim",
      \ "pi_netrw.vim",
      \ "dragvisuals.vim",
      \ "jedi-vim.vim",
      \ "quicktask.vim",
      \ "listtrans.vim",
      \ "ctrlp.vim",
      \ "markdown.vim",
      \ "youcompleteme.vim",
      \ "auto-save.vim",
      \ "pandoc.vim",
      \ "switch.vim",
      \ "neco-ghc.vim",
      \ "syntastic.vim"
      \ ]

for s:plugin in s:configs
    execute ":source " . s:settings_dir . s:plugin
endfor
" ==================================================

" vim:set et sw=2 ts=2 tw=100:

