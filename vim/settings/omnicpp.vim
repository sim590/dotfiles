au BufNewFile,BufRead,BufEnter *.c,*.h,*.cpp,*.hpp
            \ set omnifunc=omni#cpp#complete#Main | 
            \ set completeopt=menuone,menu,longest,preview |
            \ set tags+=~/.vim/tags/base |
            \ set tags+=~/.vim/tags/cpp |
            \ set tags+=~/.vim/tags/qt |
            \ set tags+=~/.vim/tags/qt4 |
            \ set tags+=~/.vim/tags/boost |
            \ set tags+=~/.vim/tags/sdl
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 0 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" build tags of your own project with Ctrl-F12
command! Ctags normal! :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
