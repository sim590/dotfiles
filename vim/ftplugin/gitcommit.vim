setlocal textwidth=80

" Save the gitcommit window current message.
fun! s:save_commit_msg()
  let l:bcursor = getcurpos()
  call cursor(1, 0)
  let l:coml = search('^#')
  if l:coml == 0
    call cursor('$', 0)
  else
    normal k
  endif
  mark '
  call cursor(1, 0)
  normal "cy''
  call setpos('.', l:bcursor)
endf

" Save the git commit message before writing the buffer. That way, if PGP
" authentication fails, the commit message is not lost.
au! BufWritePre <buffer> call s:save_commit_msg()

" vim:set et sw=2 ts=2 tw=100:

