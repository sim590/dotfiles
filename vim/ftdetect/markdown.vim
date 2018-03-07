au BufRead,BufRead qutebrowser-editor-* set filetype=markdown

" append html to markdown filetypes
au FileType markdown exec 'set filetype=' . &filetype . ".html"

" vim: set ts=2 sw=2 tw=100 et :

