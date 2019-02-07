func! vimrc#CommandAlias(abbrev, expand) abort
  execute printf('cnoreabbrev <expr> %s (getcmdtype()==":" && getcmdline()=="%s") ? "%s" : "%s"', a:abbrev, a:abbrev, a:expand, a:abbrev)
endfunc

func! vimrc#AutoFmtToggle() abort
  if &formatoptions =~# 'a'
    setl formatoptions-=a | echo '-a'
  else
    setl formatoptions+=a | echo '+a'
  endif
endfunc

func! vimrc#Ltag(term) abort
  exe "ltag " . a:term
  lopen
endfunc

" Make paths when writing, as necessary
func! vimrc#MkNonExDir(file, buf) abort
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunc

func! vimrc#AutoSessionConfig() abort
  if strlen(v:servername) > 0 && match(v:servername, 'VIM') == -1
    exec 'UniteSessionLoad ' . tolower(v:servername)
  endif
endfunc
