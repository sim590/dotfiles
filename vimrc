" PLUGIN CONFIGURATION =============================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
""" Vundle
Plugin 'gmarik/Vundle.vim'

" This is taken care by Vundle
Plugin 'L9'
Plugin 'Colour-Sampler-Pack'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'itchyny/lightline.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
"snippets --------------------
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"-----------------------------
Plugin 'fugitive.vim'
Plugin 'searchfold.vim'
Plugin 'Tabular'
Plugin 'The-NERD-tree'
Plugin 'The-NERD-Commenter'
Plugin 'EasyMotion'
Plugin 'FuzzyFinder'
Plugin 'mattn/webapi-vim' "vim-quicklink dependency
Plugin 'christoomey/vim-quicklink'
Plugin 'AndrewRadev/switch.vim'
Plugin 'ack.vim'
Plugin 'taglist.vim'
Plugin 'sjl/gundo.vim'
Plugin 'loremipsum'
Plugin 'tpope/vim-abolish' 
Plugin 'tpope/vim-surround'
Plugin 'plasticboy/vim-markdown'
Plugin 'DrawIt'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-unimpaired'
Plugin 'atweiden/vim-dragvisuals'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-eunuch'
Plugin 'sage-notebook.vim'
"Regarder syntastic
Plugin 'scrooloose/syntastic'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'Rip-Rip/clang_complete'
Plugin 'dahu/Area-41'
Plugin 'Xe/lolcode.vim'

" This is taken care by pacman (archlinux)
"Plugin 'vim-jedi' -- pacman 
"Plugin 'vim-runtime' -- pacman 
"Plugin 'vim-spell-fr' -- pacman 
call vundle#end()

filetype plugin indent on
let mapleader=","
let g:syntaxed_languages ='vim,tex,python,pyrex,c,cpp,php,js,html,css,cs,java,mkd,markdown,rst'

""" PERSONNAL PLUGIN SETTINGS
let s:settings_dir="~/.vim/settings/"
let s:configs = ["taglist.vim",
            \ "vundle.vim",
            \ "rsi.vim",
            \ "gundo.vim",
            \ "NERDCommenter.vim",
            \ "pyclewn.vim",
            \ "vim-multi-cursor.vim",
            \ "ack.vim",
            \ "fugitive.vim",
            \ "snipMate.vim",
            \ "clang_complete.vim",
            \ "ultisnips.vim",
            \ "jedi-vim.vim",
            \ "pi_netrw.vim",
            \ "dragvisuals.vim",
            \ "fuzzyfinder.vim",
            \ "markdown.vim",
            \ "syntastic.vim",
            \ "switch.vim"]
for s:plugin in s:configs
    execute ":source " . s:settings_dir . s:plugin
endfor
" ==================================================

" COMMANDS ====================================
" Start a urxvt in the current working directory
command! Shell !urxvt -cd "$PWD" &
command! YaumlPdf !yauml -Tpdf -o '%:p:t:r'.pdf '%:p:t'
" =============================================

"TODO: Comments
syntax on " enable syntax highlighting
set fo=tcroql " wraps comments after hitting <enter>, 'o' or when typing text after textwidth
set autochdir
set encoding=utf8
set hlsearch " hightlight search
set incsearch " search preview
set ignorecase " search is not case sensitive
set smartcase " smart search
set showmatch " highlight brackets
set history=50 " 50 lines of command lines history
set viminfo='20,\"50 " .viminfo file with 50 lines of registers
set ruler " show the cursor position all the time
set spelllang=fr " spellcheck language
set ai " autoindenting
set tabstop=4 " tabulation
set shiftwidth=4 " tabulation
set expandtab " tabulation
set smarttab
set softtabstop=4 " Comportement du «backspace» avec les tabs
set backspace=2 " make backspace work like most other apps
set number " line numbers
set relativenumber " relative numbers too
set laststatus=2 "status bar always show
set noshowmode
set t_Co=256 " using 256 colors (needed for colorschemes and lightline plugin)
" filetype settings
au BufRead,BufNewFile *.sage set filetype=python
au BufRead,BufNewFile *.pxd,*.pyx,*.spyx set filetype=python | set syntax=pyrex
au BufRead,BufNewFile *.tex,*.tikz,*.sagetex set filetype=tex
au BufRead,BufRead *.mustache set filetype=html
set tw=80 " wrapping lines
au BufRead,BufNewFile,Filetype python,c,cpp,java,cs,html,css,php set tw=80
au BufRead,BufNewFile,Filetype yaml set tw=40
au BufRead,BufNewFile,Filetype tex set tw=100

" COLORSCHEME ==========
colorscheme wombat256mod
" ======================

au BufRead,BufNewFile,Filetype c,cpp set si
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
