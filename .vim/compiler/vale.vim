if exists("current_compiler")
  finish
endif
let current_compiler = "vale"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:savecpo = &cpo
set cpo&vim

CompilerSet makeprg=vale\ --output=line\ %

let &cpo = s:savecpo
unlet s:savecpo
