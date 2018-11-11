let Tlist_Use_Right_Window = 1
let Tlist_Close_On_Select  = 1

fun! TlistToggleMap()
    "'#' matching the case
    if &ft =~# 'qf\|mkd\|markdown'
        return
    endif
    nmap <buffer> <leader>tL :TlistToggle<CR>
endf
au Filetype * call TlistToggleMap()
