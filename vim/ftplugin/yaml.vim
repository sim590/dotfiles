set textwidth=80

" Run Yauml on the present file
command! YaumlPdf !yauml -Tpdf -o '%:p:t:r'.pdf '%:p:t'

" vim:set et sw=2 ts=2 tw=100:

