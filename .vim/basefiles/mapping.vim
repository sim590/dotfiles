map <F2> :source $MYVIMRC<CR>
map <F3> :call Toggle_ai()<CR>
" Arborescence NERDTree 
map <F4> :NERDTree<CR>
" taglist
map <F5> :TlistUpdate<CR>
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
nmap <leader>se :split 
nmap <leader>e :edit 
nmap <leader>te :tabedit 
nmap <leader>tf yiW:tabedit <C-R>0<CR>
nmap <leader>ss :setlocal spell!<cr>
" evaluate mathematical expression selected in visual mode. 
vnoremap <silent> <Leader>mr ygvmaomb:r !perl -e '$x = <C-R>a; print $x'<CR>"ay$dd`bv`a"ap$
" same, but appends the answer instead of replacing the stirng.
vnoremap <silent> <Leader>ma yo<Esc>pV:!perl -e '$x = <C-R>a; print $x'<CR>"<CR>k$
"write the file
nmap <leader>s :w<CR>
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
" pq ça marche pas?
"imap <leader>l <leader>
" LaTeX maps
au Filetype tex 
	\ imap <buffer> <leader>it {\it }<ESC>i|
	\ imap <buffer> <leader>bf {\bf }<ESC>i|
    \ imap <buffer> <leader>tt {\tt }<ESC>i
" man page maps
au Filetype nroff 
	\ imap <buffer> <leader>it \fI \fP<ESC>Bi|
	\ imap <buffer> <leader>bf \fB \fP<ESC>Bi
" rst maps
au Filetype rst
	\ imap <buffer> <leader>it **<ESC>i|
	\ imap <buffer> <leader>bf ****<ESC>hi
" code mapping
au Filetype c,cpp,java,cs 
    \ nmap <leader>; maA;<ESC>`a
" ---------

