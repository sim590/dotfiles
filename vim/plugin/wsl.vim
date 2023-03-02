
" File: wsl.vim
" Author: Simon Désaulniers
" Description: WSL integration plugin.
" This plugin aims to integrate aspects of WSL which differ are not supported by Vim by default.
" The current state of the plugin adds support for Windows clipboard read/write capabilities.

if !exists('g:wsl_clip')
  let g:wsl_clip = 'clip.exe'
endif

if !exists('g:wsl_powershell')
  let g:wsl_powershell = 'powershell.exe'
endif

fun! s:set_w_reg_from_win_clip(bang)
  let g:wsl#powershell_clip_silent = a:bang
  if executable(g:wsl_powershell)
    let s:clipboard_job = job_start([g:wsl_powershell, 'Get-Clipboard'], {
            \ 'out_cb'   : 'wsl#powershell_clipboard_handler',
            \ 'close_cb' : 'wsl#powershell_clipboard_closing_handler'
          \ })
  endif
endf

fun s:set_win_clip_from_w_reg()
  call system(g:wsl_clip, @w)
  if v:shell_error != 0
    echoerr 'WSL: Something went wrong. Is clip.exe in the path? Are you running WSL?'
  else " never silent
    echo 'WSL: @w register was copied to Windows clipboard...'
  endif
endf

""""""""""""""
"  Commands  "
""""""""""""""

command! -bang    -bar GetPSclipboard call <SID>set_w_reg_from_win_clip(<bang>0)
command! -nargs=1 -bar Wedit          call wsl#edit(<q-args>)

""""""""""""""""""
"  Autocommands  "
""""""""""""""""""

augroup WSLYank
  autocmd!
  if executable(g:wsl_clip)
    autocmd TextYankPost * if (v:event.operator =~# '^[yd]$') && v:event.regname ==# 'w' | call <SID>set_win_clip_from_w_reg() | endif
    autocmd CmdlineEnter * GetPSclipboard!
  endif
augroup END

" vim: set sts=2 ts=2 sw=2 tw=100 et :

