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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  switch vim colorscheme without breaking colors            "
"  see: https://github.com/altercation/solarized/issues/102  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('s:known_links')
  let s:known_links = {}
endif

function! s:Find_links() " {{{1
  " Find and remember links between highlighting groups.
  redir => listing
  try
    silent highlight
  finally
    redir END
  endtry
  for line in split(listing, "\n")
    let tokens = split(line)
    " We're looking for lines like "String xxx links to Constant" in the
    " output of the :highlight command.
    if len(tokens) == 5 && tokens[1] == 'xxx' && tokens[2] == 'links' && tokens[3] == 'to'
      let fromgroup = tokens[0]
      let togroup = tokens[4]
      let s:known_links[fromgroup] = togroup
    endif
  endfor
endfunction

function! s:Restore_links() " {{{1
  " Restore broken links between highlighting groups.
  redir => listing
  try
    silent highlight
  finally
    redir END
  endtry
  let num_restored = 0
  for line in split(listing, "\n")
    let tokens = split(line)
    " We're looking for lines like "String xxx cleared" in the
    " output of the :highlight command.
    if len(tokens) == 3 && tokens[1] == 'xxx' && tokens[2] == 'cleared'
      let fromgroup = tokens[0]
      let togroup = get(s:known_links, fromgroup, '')
      if !empty(togroup)
        execute 'hi link' fromgroup togroup
        let num_restored += 1
      endif
    endif
  endfor
endfunction

function! s:AccurateColorscheme(colo_name)
  call <SID>Find_links()
  exec "colorscheme " a:colo_name
  call <SID>Restore_links()
  highlight ExtraWhiteSpaces ctermbg=red guibg=red
  autocmd ColorScheme highlight ExtraWhiteSpaces ctermbg=red guibg=red
  match ExtraWhiteSpaces /\s\+$\| \+\ze\t/
endfunction

command! -nargs=1 -complete=color MyColorscheme call <SID>AccurateColorscheme(<q-args>)

"""""""""""""""""""""""""""""""""""""""""
"  HANDLE UNWANTED CHARACTERS IN FILE   "
"""""""""""""""""""""""""""""""""""""""""

" replace false spaces by spaces
fun! s:RemoveFalseSpaces()
  let l:pos = getpos('.')
  exec ":%s/\\%o240/ /ge"
  call setpos('.', l:pos)
endf
au! BufWritePre * call s:RemoveFalseSpaces()

" get rid of trailing white spaces
fun! s:StripTrailingWhiteSpaces()
  let l:pos = getpos('.')
  exec ":%s/\\s\\+$//e"
  call setpos('.', l:pos)
endf
command! StripTrailingWhiteSpaces call s:StripTrailingWhiteSpaces()
exec "au FileType ".join(g:syntaxed_fts, ',')." au BufWritePre * call s:StripTrailingWhiteSpaces()"

