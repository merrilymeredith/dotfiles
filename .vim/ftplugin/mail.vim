function IsReply()
  if line('$') > 1
    :/^$/
    :noh
    :+1
  endif
endfunction

augroup mail_filetype
  autocmd!
  autocmd VimEnter /tmp/mutt* :call IsReply()
  autocmd VimEnter /tmp/mutt* :exe 'startinsert'
augroup END

setl textwidth=72
setl formatoptions=awn
setl spell
