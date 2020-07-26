" Start a urxvt in the current working directory
command! Shell call job_start('urxvt', {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
" Diff between the file and it's swap file
command! DiffSwp vert new | set bt=nofile | r ++edit # | 0d_  | diffthis | wincmd p | diffthis

fun! ConvertPathToHostSystemFormat(path)
  if exists('$WSLENV')
    return wsl#format_path(a:path, 'w')
  else
    return a:path
  endif
endf

" copy argument to clipboard with support for WSL
fun! CopyToClipboard(what)
  if exists('$WSLENV')
    call system('clip.exe', a:what)
  else
    call setreg('+', a:what)
  endif
  echo a:what
endf

"""""""""""""""""""""""
"  DuckDuckGo search  "
"""""""""""""""""""""""

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
        \ .(l:_option == '' ? '' : ' ').l:expression.'"')
endf
command! -nargs=+ DuckDuckgoSearch call <sid>DuckDuckgoSearch(<q-args>)

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
command! Bright MyColorscheme plasticine
command! Dark MyColorscheme wombat256mod

"""""""""""""""""""""""""""""""""""""""""
"  Handle unwanted characters in file   "
"""""""""""""""""""""""""""""""""""""""""

let s:search_replace_range = 1000

fun s:search_replace_minmax()
  return [max([1, getline('.')-s:search_replace_range/2]), min([getline('$'), getline('.')+s:search_replace_range/2])]
endf

" replace false spaces by spaces
fun! s:RemoveFalseSpaces()
  let [l:minl, l:maxl] = s:search_replace_minmax()
  let l:pos = getpos('.')
  exec ":.-" . l:minl . ",.+" . l:maxl . ";s/\\%o240/ /ge"
  call setpos('.', l:pos)
endf

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"""""""""""""""""""""""""""""""""
"  Strip Trailing white spaces  "
"""""""""""""""""""""""""""""""""
" get rid of trailing white spaces
fun! s:StripTrailingWhiteSpaces()
  let [l:minl, l:maxl] = s:search_replace_minmax()
  let l:pos = getpos('.')
  exec ":%s/\\s\\+$//e"
  call setpos('.', l:pos)
endf
command! StripTrailingWhiteSpaces call s:StripTrailingWhiteSpaces()

augroup StrippingWhiteSpaces
  autocmd!
  exec "au FileType ".join(g:programming_fts, ',').",tex "." au BufWritePre <buffer> ".
        \ "call s:RemoveFalseSpaces()"
  exec "au FileType ".join(g:syntaxed_fts, ',')." au BufWritePre <buffer> ".
        \ "call s:StripTrailingWhiteSpaces()"
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""
"  Append modeline after last line in buffer   "
""""""""""""""""""""""""""""""""""""""""""""""""
fun! AppendModeline()
  let l:modeline = printf(" vim: set sts=%d ts=%d sw=%d tw=%d %set :",
        \ &softtabstop, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  " also append a newline before and after the modeline
  call append(line("$"), ['', l:modeline, ''])
endfunction

" vim:set et sw=2 ts=2 tw=100:

