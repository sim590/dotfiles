
" mappings
nnoremap <leader>qo :QTopen<CR>
nnoremap <leader>qc :QTclose<CR>

" autocommands
augroup quicktask
    au!
    " this is personal preference, I don't want spelling on by default
    autocmd BufWinEnter,FileType quicktask set nospell
augroup end

" vim: set sts=2 ts=2 sw=2 tw=100 et :

