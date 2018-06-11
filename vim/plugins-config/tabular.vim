
""""""""""""""""""""""
"  Tabular patterns  "
""""""""""""""""""""""

fun! s:AddFirstOccurencePatterns()
  let l:c = "AddTabularPattern"
  if exists(":".l:c)
    let l:pp = {
          \ "comma1" : ",",
          \ "eq1"    : "=",
          \ "ht1"    : "#",
          \ "col1"   : ":"
          \ }
    for k in keys(pp)
      execute l:c.'! '. k .' /^[^'. pp[k] .']*\zs'. pp[k]
    endfor
  endif
endf
au! VimEnter * call s:AddFirstOccurencePatterns()

" vim: set ts=2 sw=2 tw=100 et :

