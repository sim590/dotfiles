" FUNCTIONS
"------------
fu! Toggle_ai()
    if &ai == '0'
        set ai
    else
        set noai
    endif
endfunction!


" VARIABLES
" -----------

"Place la fenêtre taglist à droite 
let Tlist_Use_Right_Window = 1
let mapleader=","
" lets exit the insert mode
let g:multi_cursor_exit_from_insert_mode = 0
" lets exit the visual mode
let g:multi_cursor_exit_from_visual_mode = 0
" -----------

"Installs plugins automatically from ~/.vim/bundle
execute pathogen#infect()

set autochdir

" enable syntax highlighting
syntax on

set encoding=utf8

" hightlight search
set hlsearch

" search preview
set incsearch

" search is not case sensitive
set ignorecase

" smart search
set smartcase

" highlight brackets 
set showmatch

" 50 lines of command lines history
set history=50

" .viminfo file with 50 lines of registers
set viminfo='20,\"50

" show the cursor position all the time
set ruler

" autoindenting
set ai

" highlights sage files like python file
au BufRead,BufNewFile *.sage,*.pyx,*.spyx set filetype=python
au BufRead,BufNewFile *.tikz,*.sagetex set filetype=tex

" tabulation
au Filetype yaml,rst,python,c,cpp,tex,java,cs set tabstop=4|set shiftwidth=4|set expandtab

set smarttab

" Comportement du «backspace» avec les tabs
set softtabstop=4

set backspace=2 " make backspace work like most other apps

" wrapping lines in rst and yaml file
au Filetype rst,yaml set tw=80
au Filetype tex set tw=100
" line numbers
set number

" enables plugins
filetype plugin indent on

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"status bar always show (needed for powerline)
set laststatus=2

" colorscheme
"colorscheme wombat256mod
colorscheme askapachecode
" using 256 colors
if !has('gui_running')
    set t_Co=256
endif


" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"sourcing my files
source ~/.vim/basefiles/mapping.vim
