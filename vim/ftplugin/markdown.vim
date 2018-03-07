if expand('%:t') =~# "qutebrowser-editor-*"
  " Writing files github, gitlab (READMEs, comments, etc.)
  setlocal textwidth=0
else
  setlocal textwidth=80
endif

" vim:set et sw=2 ts=2 tw=100:

