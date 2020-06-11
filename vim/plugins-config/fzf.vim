
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! s:project_dir()
  let l:groot = s:find_git_root()
  if has('g:FZF_PROJECT_DIR')
    return g:FZF_PROJECT_DIR
  elseif !empty(l:groot)
    return l:groot
  else
    return $PWD
  endif
endf

" Find the files that are not ignored by git if we're in a repository.
fun s:project_files_without_gitignore_files()
    let l:groot = s:find_git_root()
    if empty(l:groot)
        execute 'Files' s:project_dir()
    else
        execute 'GFiles --cached --others --exclude-standard'
    endif
endf

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {
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
    \ { 'dir': s:project_dir() },
  \ <bang>0)

" Find files from the root of the project (where .git is located) if there's
" any. This commands serve a different purpose than :GFiles or
" project_files_without_gitignore_files as it doesn't ban gitignored files.
command! ProjectFiles execute 'Files' s:project_dir()

nnoremap <leader>gf :call <SID>project_files_without_gitignore_files()<CR>
nnoremap <leader>gF :ProjectFiles<CR>
nnoremap <leader>gb :Buffers<CR>
nnoremap <leader>gw :Windows<CR>
nnoremap <leader>gh :History<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" vim: set sts=2 ts=2 sw=2 tw=100 et :

