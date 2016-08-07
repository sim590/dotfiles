"call signature was slowing down vim and not showing properly in pyrex files.
"This function and command let me get rid of it quickly, but bug should be known
"by the developer.
fun! Toggle_show_call_signatures()
    if !exists('g:jedi#show_call_signatures') || g:jedi#show_call_signatures == 1
        let g:jedi#show_call_signatures = 0
    else
        let g:jedi#show_call_signatures = 1
    endif
endf
command! JediShowCallSignatures silent call Toggle_show_call_signatures()

let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 0
let g:jedi#auto_close_doc = 0
" disabling show_call_signatures because sometimes intensively slowing down.
autocmd BufWinEnter,FileType pyrex let g:jedi#show_call_signatures = 0
autocmd BufWinEnter,FileType python let g:jedi#show_call_signatures = 0
