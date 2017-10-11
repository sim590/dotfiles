nnoremap <F8> :SyntasticCheck<CR>

"Recommended settings ----------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"-------------------------------------------------

fun! s:AddCppInclude(path)
    let g:syntastic_cpp_include_dirs += [a:path]
endf

command! -nargs=1 SyntasticAddInclude call s:AddCppInclude(<q-args>)
command! -nargs=1 SyntasticPyVer let g:syntastic_python_python_exec = "/usr/bin/python" . <args>

let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler_options = '-std=c++14'
let g:syntastic_cpp_include_dirs = ['.']
let g:syntastic_mode_map = { "mode" : "passive", "active_filetypes" : [], "passive_filetypes": ["tex"] }

let g:syntastic_haskell_checkers = [ 'ghc-mod' ]
