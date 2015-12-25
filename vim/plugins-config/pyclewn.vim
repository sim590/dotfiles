"pyclewn maps for pdb/gdb debuggin
au BufRead,BufReadPost,Filetype c,cpp,python
    \ nnoremap <leader>pc :exe "Cprint " . expand("<cword>") <CR>
    "using pyclewn Cmapkeys instead
    "old maps =============================================
    "\ nnoremap <leader>br :Cbreak "<C-R>=expand('%')<CR>:<C-R>=line('.')<CR><CR>|
    "\ nnoremap <leader>run :Crun<CR>|
    "\ nnoremap <leader>bb :Cinfo break<CR>|
    "\ nnoremap <leader>db :Cdelete |
    "\ nnoremap <leader><CR> :Cstep<CR>|
    "\ nnoremap <leader>h :Chelp |
    "\ nnoremap <leader>C :Ccontinue<CR>|
    "\ nnoremap <leader>k :Ckill<CR>|
    "\ nnoremap <leader>nx :Cnext<CR>|
    "\ nnoremap <leader>pv :Cprint |
    "======================================================
