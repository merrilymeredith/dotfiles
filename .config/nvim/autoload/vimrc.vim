func! vimrc#AutoFmtToggle() abort
  if &formatoptions =~# 'a'
    setl formatoptions-=a | echo '-a'
  else
    setl formatoptions+=a | echo '+a'
  endif
endfunc

func! vimrc#SafeFilterFile(cmd)
  let errors = tempname()
  try
    exec 'silent %!' . a:cmd . ' 2>' . shellescape(errors)
    if v:shell_error
      for line in readfile(errors)
        echomsg line
      endfor
    endif
  finally
    call delete(errors)
  endtry
endfunc
