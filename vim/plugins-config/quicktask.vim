" configurable variables
let g:QTFileName = "todo.txt"
let g:QTWindowHeight = 10

" script local variables
if !exists('QTfileNames')
    let s:QTfileNames = []
endif

fun! s:QTfileNamesAdd(fn)
    call filter(s:QTfileNames, "v:val !=# '" . a:fn . "'")
    let s:QTfileNames += [a:fn]
endf

" always 10 chars height window
fun! s:FixedSize()
    if len(tabpagebuflist())
        exe "resize " . g:QTWindowHeight
        set winfixheight
    endif
endf

" Closes the quicktask window in the current tab
fun! s:QTcloseFileInTab()
    for l:fn in s:QTfileNames
        let l:bn = bufnr(l:fn)
        if index(tabpagebuflist(), l:bn) != -1
            exe "bdelete " . l:bn
            call filter(s:QTfileNames, "v:val !=# '" . l:fn . "'")
            return
        endif
    endfor
endf

" Open the todo in seperate window
fun! s:QTopenFileInDir(filename)
    if len(a:filename)
        let l:fn = a:filename
    else
        let l:fn = g:QTFileName
    endif

    let l:path = findfile(l:fn, ".;")
    if !len(l:path)
        echoerr l:fn . " doesn't exist!"
        return
    endif

    let l:buffername = bufname(l:path)
    let l:buffnumber = bufnr(l:buffername)
    if !len(l:buffername) || index(tabpagebuflist(), l:buffnumber) == -1
        exe "split " . l:path

        if &filetype !=# 'quicktask'
            exe "q"
            echoerr l:path . " is not a quicktask file!"
            return
        endif

        " now that window is created (split), the buffer exists
        call s:QTfileNamesAdd(l:path)

        call s:FixedSize()
    endif
endf

" commands
command! QTclose silent call s:QTcloseFileInTab()
command! -nargs=? QTopen silent call s:QTopenFileInDir(<q-args>)

" mappings
nnoremap <leader>qo :QTopen<CR>
nnoremap <leader>qc :QTclose<CR>

" autocommands
augroup quicktask
    au!
    " this is personal preference, I don't want spelling on by default
    autocmd BufWinEnter,FileType quicktask set nospell
    " if the file that is opened is a quicktask file, add it to the array of
    " opened quicktask files.
    autocmd BufWinEnter,FileType quicktask call s:QTfileNamesAdd(bufname("%"))
augroup end
