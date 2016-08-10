
function! JumpAndInsert()
  if line('$') > 1
    :0
    :/^$/
    :normal 2] 
    :+1
    :exe 'startinsert'
  endif
endfunction

augroup mail_filetype
  autocmd!
  autocmd BufReadPost mutt-* :call JumpAndInsert()
augroup END

setl textwidth=72
setl formatoptions+=awt12
setl spell
