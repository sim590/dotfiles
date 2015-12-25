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

function! Toggle_ai()
    if &ai == '0'
        echo 'ai set'
        set ai
    else
        echo 'ai unset'
        set noai
    endif
endfunction!

function! ToggleRelNumber()
    if &relativenumber == 1
        set norelativenumber
    else
        set relativenumber
    endif
endfunction!

function! Toggle_diff()
    if &diff == 0
	diffthis
    else
	diffoff
    endif
endfunction!

"Fix the last spelling error
function! SpellFixLast()
    normal! m"[s1z=`"
endfunction!
