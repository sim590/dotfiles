au BufRead,BufNewFile,Filetype markdown setlocal matchpairs+=<:>
au BufRead,BufNewFile,Filetype markdown setlocal commentstring=<!--%s-->
au BufRead,BufNewFile,Filetype markdown setlocal comments=s:<!--,m:\ \ \ \ ,e:-->

au Syntax markdown syn keyword HtmlCommentTodo TODO FIXME XXX TBD contained
au Syntax markdown syn region htmlComment start=/<!--/  end=/-->/ contains=HtmlCommentTodo,@Spell
au Syntax markdown hi def link HtmlCommentTodo Todo

au BufRead,BufNewFile,Filetype markdown
            \ nnoremap <buffer> <silent> [h :HeaderDecrease<CR>|
            \ nnoremap <buffer> <silent> ]h :HeaderIncrease<CR>|
            \ nnoremap <buffer> <silent> <leader>tab :TableFormat<CR>|
            \ nnoremap <buffer> <silent> <F5> :Toch<CR>
