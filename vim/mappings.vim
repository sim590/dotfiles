vnoremap gs "+y:DuckDuckgoSearch <C-R>"
" source vim files
au Filetype vim nnoremap <F6> :source %<CR>
nnoremap <F2> :source $MYVIMRC<CR>
nnoremap <silent> <leader>spl :call SpellFixLast()<CR>
inoremap <leader>spl <ESC>:call SpellFixLast()<CR>a
nnoremap <leader>rc :e $MYVIMRC<CR>
nnoremap <leader>vrc :vsplit $MYVIMRC<CR><C-W>L
" Move the window buffer down
nnoremap <silent> <C-w>x <C-W>x<C-W>j
" add tab
nnoremap gn :tabnew<CR>
" Move the tab to the right
nnoremap <leader>mt :tabmove +1<CR>
" Move the tab to the
nnoremap <leader>mT :tabmove -1<CR>
" Close a tab
nnoremap gC :tabclose<CR>
"simple navigating in windows
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
" quickly open file using xdg-open
nnoremap <leader>o :!xdg-open &<left>
nnoremap <leader>of yiW:!xdg-open <C-R>0&<CR>
" Makefile
nnoremap <leader>mk :make<CR>
nnoremap <leader>m :make<space>
" quickly open a file
nnoremap <leader>tf yiW:tabedit <C-R>0<CR>
" spell
nnoremap <leader>sl :set spelllang=
" evaluate mathematical expression selected in visual mode.
vnoremap <silent> <Leader>mr "aygvmaomb<ESC>:r !perl -e '$x = <C-R>a; print $x'<CR>"ay$dd`bv`a"ap$
" same, but appends the answer instead of replacing the stirng.
vnoremap <silent> <Leader>ma "ayo<Esc>pV:!perl -e '$x = <C-R>a; print $x'<CR>"<CR>k$
" quickly change text width
nnoremap <silent> <leader>stw :set tw=
" move block of text
vnoremap < <gv
vnoremap > >gv
"write the file
nnoremap <leader>w :w<CR>
" adds brackets and prepare for insertion
inoremap <leader>< <><ESC>i
" get out of the container: (),{},[]
inoremap <leader>x <ESC>l%%a
" underline with specified char
nnoremap <leader>T ^y$o<ESC>pVr
nnoremap <silent> <leader>l :%s/\s\+$//e \| let @/=""<CR><C-O>
nnoremap <silent> <leader>L :noh<CR>
" vimdiff
nnoremap <silent> <leader>U :diffupdate<CR>
vnoremap <silent> <leader>dp :diffput<CR>
vnoremap <silent> <leader>do :diffget<CR>

nnoremap <buffer> <leader>; mzA;<ESC>`z

" HTML maps
au Syntax html
    \ nnoremap <buffer> <leader>it ciwem><ESC>4hP|
	\ inoremap <buffer> <leader>it <em></em><ESC>4hi|
    \ nnoremap <buffer> <leader>it ciw<b></b><ESC>3hP|
	\ inoremap <buffer> <leader>bf <b></b><ESC>3hi
" LaTeX maps
au Syntax tex
    \ nnoremap <buffer> <leader>it ciw\emph{}<ESC>P|
    \ inoremap <buffer> <leader>it \emph{}<ESC>i|
	\ inoremap <buffer> <leader>ti {\tiny }<ESC>i|
    \ nnoremap <buffer> <leader>bf ciw{\bfseries }<ESC>P|
	\ inoremap <buffer> <leader>bf {\bfseries }<ESC>i|
	\ inoremap <buffer> <leader>li {\ttfamily }<ESC>i|
    \ nnoremap <buffer> <leader>li ciw{\ttfamily }<ESC>P|
	\ inoremap <buffer> <leader>$ $$<ESC>i|
	\ inoremap <buffer> <leader>lr] \left[\right]<ESC>F\i|
	\ inoremap <buffer> <leader>lr[ \left[\right]<ESC>F\i|
	\ inoremap <buffer> <leader>lr( \left(\right)<ESC>F\i|
	\ inoremap <buffer> <leader>lr) \left(\right)<ESC>F\i|
	\ inoremap <buffer> <leader>\| \|\|<ESC>i|
    \ nnoremap <buffer> <leader>tk :!pdflatex %<CR>
" man page maps
au Syntax nroff,groff,troff
	\ inoremap <buffer> <leader>it \fI\fP<ESC>2hi|
	\ inoremap <buffer> <leader>bf \fB\fP<ESC>2hi
" rst maps
au Syntax mkd,markdown,rst,python
	\ inoremap <buffer> <leader>it **<ESC>i|
	\ inoremap <buffer> <leader>bf ****<ESC>hi|
	\ inoremap <buffer> <leader>li ``<ESC>i
