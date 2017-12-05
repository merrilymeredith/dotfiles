if exists("current_compiler")
  finish
endif
let current_compiler = "rubocop"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:savecpo = &cpo
set cpo&vim

CompilerSet makeprg=rubocop\ -f\ c\ %
CompilerSet errorformat=%f:%l:%c:\ %t:\ %m,%E%f:%l:\ %m

let &cpo = s:savecpo
unlet s:savecpo
