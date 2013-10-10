map <F2> :source $MYVIMRC<CR>
map <F3> :call Toggle_ai()<CR>
" Arborescence NERDTree 
map <F4> :NERDTree<CR>
" taglist
map <F5> :TlistUpdate<CR>
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
	\ imap <leader>it {\it }<ESC>i|
	\ imap <leader>bf {\bf }<ESC>i|
    \ imap <leader>tt {\tt }<ESC>i
" man page maps
au Filetype nroff 
	\ imap <leader>it \fI \fP<ESC>Bi|
	\ imap <leader>bf \fB \fP<ESC>Bi
" rst maps
au Filetype rst
	\ imap <leader>it **<ESC>i|
	\ imap <leader>bf ****<ESC>hi
" code mapping
au Filetype c,cpp,java,cs 
    \ nmap <leader>; maA;<ESC>`a
" ---------

