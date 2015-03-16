nnoremap <F8> :SyntasticToggleMode<CR>

"Recommended settings ----------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"-------------------------------------------------

let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_mode_map = { 
            \ "mode" : "passive",
            \ "active_filetypes" : [],
            \ "passive_filetypes": []}
