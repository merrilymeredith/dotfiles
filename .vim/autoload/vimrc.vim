
function! vimrc#AutoFmtToggle() abort
  if &formatoptions =~ 'a'
    setl fo-=a
    echo '-a'
  else
    setl fo+=a
    echo '+a'
  endif
endfunction

" Make paths when writing, as necessary
function! vimrc#MkNonExDir(file, buf) abort
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

