fun! s:DuckDuckgoSearch(q_args)
  let l:_args = split(a:q_args)
  let l:index = match(l:_args[0], '-[a-zA-Z]\+')

  if l:index != -1
    let l:_option = l:_args[l:index]
  else
    let l:_option = ''
  endif

  let l:expression = join(l:_args[l:index+1:])
  call system('xdg-open "https://duckduckgo.com/?q='
        \ .escape(substitute(l:_option, '-', '!', ""), '!')
        \ .' '.l:expression.'"')
endf
command! -nargs=+ DuckDuckgoSearch call <sid>DuckDuckgoSearch(<q-args>)

"Fix the last spelling error
function! SpellFixLast()
    normal! m"[s1z=`"
endfunction!

fun! s:StringBaseConvert(str, a, b)
    "TODO: prendre le string en dessous du curseur.
    "TODO: parse '0x' prefix string.
    return system('echo "obase='.a:b.'; $(('.a:a.'#'.a:str.'))" | bc')
endf
