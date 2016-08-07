"TODO: bug mémoire très élevé...
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_list_select_completion = ['<c-n>']
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '/home/simon/.ycm_extra_conf.py'

"MAPPINGS
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jD :YcmCompleter GoToDefinition<CR>
nnoremap <leader>dc :YcmCompleter GetDoc<CR>
