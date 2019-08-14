setlocal textwidth=120
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <Leader>lk :call LanguageClient#textDocument_hover()<CR>
nnoremap <Leader>lg :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <Leader>lb :call LanguageClient#textDocument_references()<CR>
nnoremap <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

" vim:set et sw=2 ts=2 tw=100:

