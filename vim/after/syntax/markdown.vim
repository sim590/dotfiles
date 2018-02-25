syn keyword HtmlCommentTodo TODO FIXME XXX TBD contained
syn region htmlComment start=/<!--/  end=/-->/ contains=HtmlCommentTodo,@Spell
hi def link HtmlCommentTodo Todo

" vim: set ts=2 sw=2 tw=100 et :

