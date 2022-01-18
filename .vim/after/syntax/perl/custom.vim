" this keeps indents from jumping more than one level
let b:indent_use_syntax = 0

syn sync minlines=1500

" Weird behavior in sql heredocs
syn clear sqlFold

" fix highlight-all-pragma for vN.NN
syn match perlStatementInclude   "\<\%(use\|no\)\s\+v\(\d\|.\)\+"

" Add match for =method and =func from Pod::Weaver
syn match podCommand "^=method" contained nextgroup=podCmdText contains=@NoSpell
syn match podCommand "^=func" contained nextgroup=podCmdText contains=@NoSpell

" Add matches for contrib/function-parameters.vim, but don't apply to fat-arrow cases
syn match perlFunction +\<method\>\(\_s*=>\)\@!\_s*+ nextgroup=perlSubName
syn match perlFunction +\<fun\>\(\_s*=>\)\@!\_s*+ nextgroup=perlSubName

" Tweak some colors, making POD stand out less
hi! def link perlPOD      Comment
hi! def link podOrdinary  Comment
hi! def link podCommand   SpecialComment
hi! def link podCmdText   Question
hi! def link podFormat    StorageClass
