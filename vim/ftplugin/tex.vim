"""""""""""""
"  Options  "
"""""""""""""
setlocal textwidth=100
setlocal tabstop=2
setlocal shiftwidth=2

""""""""""""""
"  Commands  "
""""""""""""""
" Estimate the number of words in the LaTeX file
command! WcLatex write !detex | wc -w

""""""""""""""
"  Mappings  "
""""""""""""""
nnoremap <buffer> <leader>tk :!pdflatex %<CR>

" vim:set et sw=2 ts=2 tw=100:

