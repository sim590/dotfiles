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
au BufRead,BufNewFile,Filetype yaml command! YaumlPdf !yauml -Tpdf -o '%:p:t:r'.pdf '%:p:t'
au BufRead,BufNewFile,FileType tex command! WcLatex write !detex | wc -w
" =============================================

"TODO: Comments
syntax on                          " enable syntax highlighting
set fo=tcroql                      " wraps comments after hitting <enter>, 'o'
                                   " or when typing text after textwidth
set autochdir
set encoding=utf-8
set hlsearch                       " hightlight search
set incsearch                      " search preview
set ignorecase                     " search is not case sensitive
set smartcase                      " smart search
set showmatch                      " highlight brackets
set history=50                     " 50 lines of command lines history
set viminfo='20,\"50               " .viminfo file with 50 lines of registers
set ruler                          " show the cursor position all the time
set spelllang=fr                   " spellcheck language
set ai                             " autoindenting
set tw=120                         " text wraping
set tabstop=4                      " tabulation
set shiftwidth=4                   " tabulation
set softtabstop=4                  " tabulation
set expandtab                      " tabulation
au BufRead,BufNewFile,FileType cmake,automake set noexpandtab
set smarttab
set backspace=2    " make backspace work like most other apps
set cursorcolumn
set number         " line numbers
set relativenumber " relative numbers too
set laststatus=2   " status bar always show
set noshowmode

"""""""""""""""""""""""
"  filetype settings  "
"""""""""""""""""""""""
" LaTeX
au BufRead,BufNewFile,FileType *.tex,*.tikz,*.sagetex
      \ set filetype=tex|
      \ set tw=100|
      \ set ts=2|
      \ set sw=2
" pandoc
au BufRead,BufNewFile,FileType vim,pandoc
      \ set tw=100|
      \ set ts=2|
      \ set sw=2
" python
au BufRead,BufNewFile *.sage set filetype=python
au BufRead,BufNewFile *.pxd,*.pyx,*.spyx
      \ set filetype=python |
      \ set syntax=pyrex
" html
au BufRead,BufRead *.mustache set filetype=html

au BufRead,BufNewFile,FileType gitcommit,mail,*.yaml,*.yml,*.md set tw=80

" code
exec "au BufRead,BufNewFile,FileType ".join(g:programming_fts, ',')." ".
            \ "set tw=120|"
            \ "set ts=4|"
            \ "set sw=4"
" others
au BufRead,BufNewFile ~/.mutt/* set filetype=muttrc

" syntaxed filetypes
exec "au BufRead,BufNewFile,Filetype ".join(g:syntaxed_fts, ',')." set si"

" TODO:
" save and recover folding areas
"autocmd BufWrite * mkview
"autocmd BufRead * silent loadview

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

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

