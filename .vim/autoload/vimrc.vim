
func! vimrc#AutoFmtToggle() abort
  if &formatoptions =~ 'a'
    setl fo-=a | echo '-a'
  else
    setl fo+=a | echo '+a'
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
    let g:unite_source_session_default_session_name = tolower(v:servername)
    let g:unite_source_session_enable_auto_save = 1

    UniteSessionLoad
  endif
endfunc

func! vimrc#VundleInstallAndBegin() abort
  if !filereadable(g:myvim . '/bundle/vundle/README.md')
    if !executable('git')
      echo "Can't autoinstall Vundle without git"
      return
    endif

    try
      call mkdir(g:myvim . '/bundle', 'p')
    catch
    endtry
    exec 'cd ' . g:myvim . '/bundle'
    silent !git clone --depth 1 https://github.com/gmarik/vundle
    cd -

    echo "Installed Vundle, run :PluginInstall if desired"
  endif

  let &rtp .= ',' . g:myvim . '/bundle/vundle'
  call vundle#begin(g:myvim . '/bundle')
endfunc
