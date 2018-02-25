
au BufRead,BufNewFile,Filetype markdown
            \ nnoremap <buffer> <silent> [h :HeaderDecrease<CR>|
            \ nnoremap <buffer> <silent> ]h :HeaderIncrease<CR>|
            \ nnoremap <buffer> <silent> <leader>tab :TableFormat<CR>|
            \ nnoremap <buffer> <silent> <F5> :Toch<CR>

" vim: set ts=2 sw=2 tw=100 et :

