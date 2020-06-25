
" File: wsl.vim
" Author: Simon Désaulniers
" Description: Public utilities for WSL.

let g:wsl#async_data_buffer = []

fun wsl#edit(path)
  let l:unix_path = wsl#format_path(escape(a:path, '\'), 'u')
  execute 'edit ' . l:unix_path
endf

fun! wsl#format_path(path, type)
  let l:wslpath_out = systemlist("wslpath" . " -" . a:type . " '" . a:path . "' " . "2>/dev/null")
  if !empty(l:wslpath_out)
    return l:wslpath_out[0]
  else
    return a:path
  endif
endf

fun! wsl#powershell_clipboard_handler(channel, msg)
  let g:wsl#async_data_buffer += [a:msg]
endf

fun! wsl#powershell_clipboard_closing_handler(channel)
  call setreg('w', join(g:wsl#async_data_buffer, "\n"))
  let g:wsl#async_data_buffer = []
  if !g:wsl#powershell_clip_silent
    echo 'WSL: clipboard was copied from Windows to register w...'
  endif
endf

" vim: set sts=2 ts=2 sw=2 tw=100 et :

