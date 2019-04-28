nnoremap <buffer> go :Git checkout<space>

nnoremap <buffer> gp :Gpush origin<CR>
nnoremap <buffer> gP :Gpush origin -f

nnoremap <buffer> gb :Git branch -u<space>
nnoremap <buffer> gu :Git branch -u master<CR>
nnoremap <buffer> gU :Git branch -u origin/<c-r>=system('git symbolic-ref -q HEAD \| cut -d/ -f3')<CR><CR>

" vim: set sts=2 ts=2 sw=2 tw=100 et :

