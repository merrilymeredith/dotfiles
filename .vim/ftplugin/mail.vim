
function! JumpAndInsert()
  if line('$') > 1
    :0
    :/^$/
    :normal 2] 
    :+1
    :exe 'startinsert'
  endif
endfunction

function! AutoFmtToggle()
  if &formatoptions =~ 'a'
    set fo-=a
    echo '-a'
  else
    set fo+=a
    echo '+a'
  endif
endfunction

augroup mail_filetype
  autocmd!
  autocmd BufReadPost mutt-* :call JumpAndInsert()
augroup END

setl textwidth=72
setl formatoptions=aw
setl spell

map <silent> <leader>a :call AutoFmtToggle()<CR>
imap <silent> <leader>a :call AutoFmtToggle()<CR>
