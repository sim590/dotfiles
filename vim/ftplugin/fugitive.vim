
nnoremap <buffer> go :Git checkout<space>

nnoremap <buffer> gp :Git push<CR>
nnoremap <buffer> gP :Git push -f

nnoremap <buffer> gb :Git branch -u<space>
nnoremap <buffer> cu :Git branch -u master<CR>

" NOTE: Function for this (calling git and making a change to the directory `.git`) can't be used in
" this file since Fugitive seems to reload it and that breaks since you cannot define a function
" with the same name as the one that is being executed.
nnoremap <expr> <buffer> cU ":Git branch -u origin/" .
      \ substitute(
        \ systemlist('git symbolic-ref -q HEAD')[0],
        \ '^.*\/', '', ''
        \ ) . "<cr>"

" vim: set sts=2 ts=2 sw=2 tw=100 et :

