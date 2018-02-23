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
Plug 'tpope/vim-fugitive' " TODO: nvim-compatible
Plug 'tpope/vim-rhubarb'
Plug 'searchfold.vim'
Plug 'godlygeek/tabular' "Must load before vim-markdown (see :h vim-markdown)
"Plug 'The-NERD-Commenter'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
" Plug 'FuzzyFinder' " issue with opening files when have split buffers.
                     " Doesn't open the file in the right buffer or just doesn't
                     " open the file correctly (empty buffer).
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/webapi-vim' "vim-quicklink dependency
Plug 'christoomey/vim-quicklink'
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
Plug 'scrooloose/syntastic' " TODO: nvim-compatible
Plug 'Valloric/YouCompleteMe', { 'do' : './install.py --system-libclang --clang-completer --cs-completer' } " TODO: nvim-compatible
Plug 'rdnetto/YCM-Generator', 'stable' " TODO: nvim-compatible
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
      \ "mkd",
      \ "markdown",
      \ "rst",
      \ "cmake",
      \ "make"
      \ ]

" COMMANDS ====================================
" Start a urxvt in the current working directory
command! Shell !urxvt -cd "$PWD" &
command! DiffSwp vert new | set bt=nofile | r ++edit # | 0d_  | diffthis | wincmd p | diffthis
" =============================================

" TODO:
" save and recover folding areas
"autocmd BufWrite * mkview
"autocmd BufRead * silent loadview

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" CUSTOM CONFIGURATION ==========
source ~/.vim/abbreviations.vim
source ~/.vim/functions.vim
source ~/.vim/mappings.vim
" ===============================

" COLORSCHEME ==========
MyColorscheme wombat256mod
" ======================

""" PERSONNAL PLUGIN SETTINGS
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

