
let g:FUGITIVE_DIFF_REFERENCE = 'HEAD'

fun s:DiffAgainstDiffReference()
  execute 'Gvdiffsplit ' . g:FUGITIVE_DIFF_REFERENCE
  echo 'Diff against ' . g:FUGITIVE_DIFF_REFERENCE
endf

nnoremap <leader>gs :cd.<CR>:Gstatus<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gD :Gdiffsplit<CR>

nmap ]d <c-w>o]q:call <SID>DiffAgainstDiffReference()<CR>
nmap [d <c-w>o[q:call <SID>DiffAgainstDiffReference()<CR>

" vim: set sts=2 ts=2 sw=2 tw=100 et :

