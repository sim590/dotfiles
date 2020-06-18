""""""""""""""""""""""""""""""""""""
"  Editing & Navigation & Windows  "
""""""""""""""""""""""""""""""""""""
"simple window navigation
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
" Move the window buffer down
nnoremap <silent> <C-w>x <C-W>x<C-W>j
" add tab
" Move the tab to the right
nnoremap gr :tabmove +1<CR>
" Move the tab to the
nnoremap gl :tabmove -1<CR>
" Close a tab
nnoremap gC :tabclose<CR>
" move block of text
vnoremap < <gv
vnoremap > >gv
" underline with specified char
nnoremap <leader>T ^y$o<ESC>pVr
" remove trailing white spaces
nnoremap <silent> <leader>l :%s/\s\+$//e \| let @/=""<CR><C-O>
" append modeline at the end of file
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

"""""""""""""""""""""
"  Shell, programs  "
"""""""""""""""""""""
nnoremap <leader>yp :YaumlPdf<CR>
vnoremap gs "+y:DuckDuckgoSearch <C-R>"

nnoremap <leader>cf :call CopyToClipboard(ConvertPathToHostSystemFormat(expand("%:t")))<CR>
nnoremap <leader>cp :call CopyToClipboard(ConvertPathToHostSystemFormat(expand("%:p")))<CR>
nnoremap <leader>cd :call CopyToClipboard(ConvertPathToHostSystemFormat(expand("%:p:h")))<CR>

" quickly open file using xdg-open
nnoremap <leader>o :!xdg-open &<left>
nnoremap <leader>of yiW:!xdg-open <C-R>0&<CR>

" Makefile
nnoremap <leader>mk :make<CR>
nnoremap <leader>m :make<space>

"""""""""""""""
"  Vim files  "
"""""""""""""""
" source vim files
au Filetype vim nnoremap <F6> :source %<CR>
nnoremap <leader>rc :e $MYVIMRC<CR>
nnoremap <F2> :source $MYVIMRC<CR>
nnoremap <leader>vrc :vsplit $MYVIMRC<CR><C-W>L

""""""""""""""
"  Spelling  "
""""""""""""""
" fix last spelling error
nnoremap <silent> <leader>spl m"[s1z=`"
inoremap <leader>spl <ESC>:call SpellFixLast()<CR>a
" set spell option cmdline text
nnoremap <leader>sl :set spelllang=

"""""""""""
"  Maths  "
"""""""""""
" evaluate mathematical expression selected in visual mode.
vnoremap <silent> <Leader>mr "aygvmaomb<ESC>:r !perl -e '$x = <C-R>a; print $x'<CR>"ay$dd`bv`a"ap$
" same, but appends the answer instead of replacing the stirng.
vnoremap <silent> <Leader>ma "ayo<Esc>pV:!perl -e '$x = <C-R>a; print $x'<CR>"<CR>k$

" quickly change text width
nnoremap <silent> <leader>stw :set tw=
"write the file
nnoremap <leader>w :w<CR>
nnoremap <silent> <leader>L :noh<CR>

""""""""""""""
"  Vim diff  "
""""""""""""""
nnoremap <silent> <leader>U :diffupdate<CR>
vnoremap <silent> <leader>dp :diffput<CR>
vnoremap <silent> <leader>do :diffget<CR>

"""""""""""""""
"  Termdebug  "
"""""""""""""""
let s:termdebug_augroup = "TERMDEBUG"
fun! s:clear_terminalbuf_map(mode, lhs, opts, fts)
  bufdo! if index(a:fts, &filetype) >= 0
        \ | silent! execute a:mode . "unmap " . a:opts . " " . a:lhs
        \ | endif
endf
fun! s:map_if_terminalbuf_ft(mode, lhs, rhs, opts, fts)
  let l:pfts = join(a:fts, ',*.')
  let l:pfts = '*.' . l:pfts
  if &buftype == 'terminal'
    execute "augroup " . s:termdebug_augroup
    execute " au BufEnter ". l:pfts . " " . a:mode . "noremap " . a:opts . " " . a:lhs . " " . a:rhs
    augroup END
    let args = "'".join([a:mode, a:lhs, a:opts], "','")."',"."['".join(a:fts, "','")."']"
    execute "au BufWinLeave * if &buftype == 'terminal' | call <SID>clear_terminalbuf_map(".l:args.")"." | endif"
  endif
endf
fun! s:advance_line()
  let ln = line(".")
  execute "call TermDebugSendCommand('advance ". l:ln ."')"
endf

" clear autocommands before creating them
silent! execute "augroup! " . s:termdebug_augroup . "| augroup! END"
let s:termdebug_fts = ['c', 'cpp']
au TerminalOpen * call s:map_if_terminalbuf_ft('v', '<leader>e', ":Evaluate<CR>", '<buffer>', s:termdebug_fts)
au TerminalOpen * call s:map_if_terminalbuf_ft('n', '<leader>b', ":Break<CR>", '<buffer>', s:termdebug_fts)
au TerminalOpen * call s:map_if_terminalbuf_ft('n', '<leader>cl', ":Clear<CR>", '<buffer>', s:termdebug_fts)
au TerminalOpen * call s:map_if_terminalbuf_ft('n', ']n', ":call TermDebugSendCommand('next')<CR>", '<buffer>', s:termdebug_fts)
au TerminalOpen * call s:map_if_terminalbuf_ft('n', ']s', ":call TermDebugSendCommand('step')<CR>", '<buffer>', s:termdebug_fts)
au TerminalOpen * call s:map_if_terminalbuf_ft('n', ']a', ":call <SID>advance_line()<CR>", '<buffer>', s:termdebug_fts)
au TerminalOpen * call s:map_if_terminalbuf_ft('n', '<leader>cc', ":call TermDebugSendCommand('continue')<CR>", '<buffer>', s:termdebug_fts)
au BufWinLeave * if &buftype == 'terminal' | silent! execute "autocmd! " . s:termdebug_augroup | endif " clear map autocommands when quitting terminal window

" vim:set et sw=2 ts=2 tw=100:

