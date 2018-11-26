set formatoptions=tcroql
set autochdir
set encoding=utf-8
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set history=50
set viminfo='20,\"50
set ruler
set spelllang=fr
set autoindent
set textwidth=120
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set backspace=2
set cursorcolumn
set number
set relativenumber
set laststatus=2
set noshowmode
set modeline
set foldlevelstart=2

packadd termdebug " Enables gdb debugging

" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" vim:set et sw=2 ts=2 tw=100:

