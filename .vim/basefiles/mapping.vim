map <F2> :source $MYVIMRC<CR>
map <F3> :call Toggle_ai()<CR>
map <leader>n :call ToggleRelNumber()<CR>
" Arborescence NERDTree 
map <F4> :NERDTreeToggle<CR>
" taglist
map <F5> :TlistToggle<CR>
map <leader>tu :TlistUpdate<CR>
" search the word under the cursor with firefox
"---------------------------------------------------
nmap <leader>s/ yiW:!firefox -new-tab "https://duckduckgo.com/?q=<C-R>0"&
vmap <leader>s/ y:!firefox -new-tab "https://duckduckgo.com/?q=<C-R>0"&
" search on Larousse.fr
nmap <leader>s/fr yiW:!firefox -new-tab "https://duckduckgo.com/?q=\!fr <C-R>0"&
vmap <leader>s/fr y:!firefox -new-tab "https://duckduckgo.com/?q=\!fr <C-R>0"&
" search on wikipedia
nmap <leader>s/w yiW:!firefox -new-tab "https://duckduckgo.com/?q=\!w <C-R>0"&
vmap <leader>s/w y:!firefox -new-tab "https://duckduckgo.com/?q=\!w <C-R>0"&
"---------------------------------------------------
" Move the tab to the right
nmap <leader>mt :tabmove +1<CR>
" Move the tab to the 
nmap <leader>mT :tabmove -1<CR>
" Close a tab
nmap gc :tabclose<CR>
"adding line below
nmap go  o<ESC>k
"adding line above
nmap gO O<ESC>j
"simple navigating in windows
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
" quickly open PDF
nmap <leader>p :!evince 
nmap <leader>pf yiW:!evince <C-R>0&<CR>
" Makefile
nmap <leader>mk :make<CR>
nmap <leader>m :make 
" quickly open a file
nmap <leader>e :FufFile<CR>
nmap <leader>tf yiW:tabedit <C-R>0<CR>
nmap <leader>sw yiW:Ack <C-R>0<CR>
nmap <leader>ss :setlocal spell!<cr>
" buffer navigation
" -----------------
" change buffer
nmap <leader>bc :FufBuffer<CR>
" evaluate mathematical expression selected in visual mode. 
vnoremap <silent> <Leader>mr "aygvmaomb<ESC>:r !perl -e '$x = <C-R>a; print $x'<CR>"ay$dd`bv`a"ap$
" same, but appends the answer instead of replacing the stirng.
vnoremap <silent> <Leader>ma "ayo<Esc>pV:!perl -e '$x = <C-R>a; print $x'<CR>"<CR>k$
" move block of text
vmap < <gv
vmap > >gv
"write the file
nmap <leader>w :w<CR>
"move a line up and down
nmap <S-l> mz:m+<cr>`z
nmap <S-h> mz:m-2<cr>`z
" adds brackets and prepare for insertion
imap <leader>" ""<ESC>i
imap <leader>' ''<ESC>i
imap <leader>[ []<ESC>i|imap <leader>] []<ESC>i
imap <leader>( ()<ESC>i|imap <leader>) ()<ESC>i
imap <leader>{ {}<ESC>i|imap <leader>} {}<ESC>i
" get out of the container: (),{},[] 
imap <leader>x <ESC>l%%a
nmap <leader>T YpVr
nmap <leader>; maA;<ESC>`a
" LaTeX maps
au Filetype tex 
	\ imap <buffer> <leader>it {\it }<ESC>i|
	\ imap <buffer> <leader>bf {\bf }<ESC>i|
    \ imap <buffer> <leader>tt {\tt }<ESC>i|
    \ imap <buffer> <leader>$ $$<ESC>i|
    \ nmap <buffer> <leader>; maA;<ESC>`a
" man page maps
au Filetype nroff 
	\ imap <buffer> <leader>it \fI \fP<ESC>Bi|
	\ imap <buffer> <leader>bf \fB \fP<ESC>Bi
" rst maps
au Filetype rst,python 
	\ imap <buffer> <leader>it **<ESC>i|
	\ imap <buffer> <leader>bf ****<ESC>hi|
    \ imap <buffer> <leader>li ````<ESC>hi|
" ---------

