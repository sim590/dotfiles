
""""""""""""""
"  Coloring  "
""""""""""""""

syntax match Keyword "\<return\>"
syntax match Keyword "\<foldl\>"
syntax match Keyword "\<foldl1\>"
syntax match Keyword "\<foldr\>"
syntax match Keyword "\<zip\>"
syntax match Keyword "\<length\>"

""""""""""""""""
"  Concealing  "
""""""""""""""""

syntax match hsNiceOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ
syntax match hsNiceOperator /\s\.\s/ms=s+1,me=e-1 conceal cchar=∘

hi link hsNiceOperator Operator
hi! link Conceal Operator
setlocal conceallevel=2

" vim: set sts=2 ts=2 sw=2 tw=100 et :

