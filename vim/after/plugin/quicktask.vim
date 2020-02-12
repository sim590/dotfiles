
fun! MyQTInit()
  call QTInit()
  let l:subs = {
        \ 'CURRENT TASKS' : 'TÂCHES COURANTES',
        \ 'My first task' : 'Ma première tâche',
        \ 'COMPLETED TASKS' : 'TÂCHES COMPLÉTÉES'
        \ }
  for [l:k,l:v] in items(l:subs)
    execute '%substitute/'.l:k.'/'.l:v.'/'
  endfor
endf
command! QTInit call MyQTInit()

" vim: set sts=2 ts=2 sw=2 tw=100 et :

