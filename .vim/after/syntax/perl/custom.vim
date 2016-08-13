compiler perl
" even with g:perl_compiler_force_warnings = 0, perl -w is used and
" that's just noisy with intentional no-warnings blocks out there

setlocal makeprg=perl\ -c\ %\ $*
setlocal iskeyword+=:

" this keeps indents from jumping more than one level
let b:indent_use_syntax = 0

" Add match for =method and =func from Pod::Weaver
syn match podCommand "^=method" contained nextgroup=podCmdText contains=@NoSpell
syn match podCommand "^=func" contained nextgroup=podCmdText contains=@NoSpell

syn sync minlines=15

" Tweak some colors
hi! def link perlPOD      Comment
hi! def link podCommand   SpecialComment
hi! def link podCmdText   Question
hi! def link podFormat    StorageClass
