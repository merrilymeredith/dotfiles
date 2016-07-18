
function JumpAndInsert()
  if line('$') > 1
    :/^$/
    :normal 2] 
    :+1
    :exe 'startinsert'
  endif
endfunction

augroup mail_filetype
  autocmd!
  autocmd VimEnter /tmp/mutt* :call JumpAndInsert()
augroup END

setl textwidth=72
setl formatoptions=aw
setl spell
