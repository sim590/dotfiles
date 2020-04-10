
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {
        \ 'source' : 'find .',
        \ 'options': [
            \ '--layout=reverse',
            \ '--info=inline',
            \ '--preview',
            \ '~/.vim/plugged/fzf.vim/bin/preview.sh {}'
        \ ]
    \ }, <bang>0)

command! -bang -nargs=* PRg
  \ call fzf#vim#grep(
    \ "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
    \ 1,
    \ { 'dir': s:find_git_root() },
  \ <bang>0)

command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <leader>gf :ProjectFiles<CR>
nnoremap <leader>gb :Buffers<CR>
nnoremap <leader>gw :Windows<CR>
nnoremap <leader>gh :History<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" vim: set sts=2 ts=2 sw=2 tw=100 et :

