" mjibson/sqlfmt - only does cockroachdb dialect
" this kinda sucks as far as placeholders and can't pass through odd syntax

" let &l:formatprg = "sqlfmt --use-spaces --tab-width " . &shiftwidth
" augroup SQLFMT_ERR
"   au! * <buffer>
"   autocmd ShellFilterPost <buffer> if v:shell_error | undo | endif
" augroup END

" cpanm https://github.com/darold/pgFormatter.git
"let &l:formatprg = "pg_format -"
let &l:omnifunc = "syntaxcomplete#Complete"
