
let s:current_syntax = b:current_syntax
unlet b:current_syntax
syn include @Pod syntax/pod.vim
syn region shPOD        start="^=pod" start="^=head" end="^=cut" keepend contained contains=@Pod
let b:current_syntax = s:current_syntax

syn region shPODHeredoc start="^:<<=cut" end="^=cut" keepend contains=shPOD

hi! def link shPOD        Comment
hi! def link podCommand   SpecialComment
hi! def link podCmdText   Question
hi! def link podFormat    StorageClass

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
