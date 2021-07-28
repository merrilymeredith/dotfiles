" adapted from https://gist.github.com/jbolila/7598018
let g:tagbar_type_perl = {
    \ 'ctagstype'   : 'Perl',
    \ 'kinds' : [
        \ 'p:packages:1:0',
        \ 'u:uses:1:0',
        \ 'r:requires:1:0',
        \ 'e:extends',
        \ 'w:roles',
        \ 'o:ours:1:0',
        \ 'c:constants:1:0',
        \ 'f:formats:1:0',
        \ 'a:attributes',
        \ 'm:methods',
        \ 's:subroutines',
        \ 'x:modifier',
        \ 'l:aliases',
        \ 'd:pod:1:0',
    \ ],
    \ 'deffile' : g:myvim . '/ctags/perl.cnf'
\ }

let g:tagbar_type_elixir = {
  \ 'ctagstype' : 'Elixir',
  \ 'kinds' : [
    \ 'm:modules:1:0',
    \ 'r:records',
    \ 'f:functions',
    \ 'a:macros',
    \ 'o:operators',
    \ 'p:protocols',
    \ 'i:implementations',
    \ 'd:delegates',
    \ 'c:callbacks',
    \ 'e:exceptions',
  \ ],
\ }

" https://github.com/jstemmer/gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" https://github.com/wsdjeg/mdctags.rs
let g:tagbar_type_markdown = {
  \ 'ctagsbin'  : 'mdctags',
  \ 'ctagsargs' : '',
  \ 'sort'      : 0,
  \ 'kinds'     : [
  \     'a:h1:0:0',
  \     'b:h2:0:0',
  \     'c:h3:0:0',
  \     'd:h4:0:0',
  \     'e:h5:0:0',
  \     'f:h6:0:0',
  \ ],
  \ 'sro'        : '::',
  \ 'kind2scope' : {
  \     'a' : 'h1',
  \     'b' : 'h2',
  \     'c' : 'h3',
  \     'd' : 'h4',
  \     'e' : 'h5',
  \     'f' : 'h6',
  \ },
  \ 'scope2kind' : {
  \     'h1' : 'a',
  \     'h2' : 'b',
  \     'h3' : 'c',
  \     'h4' : 'd',
  \     'h5' : 'e',
  \     'h6' : 'f',
  \}
\}
