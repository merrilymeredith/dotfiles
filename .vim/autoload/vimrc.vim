
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
    exec 'UniteSessionLoad ' . tolower(v:servername)
  endif
endfunc

func! vimrc#VundleInstallAndBegin() abort
  let bundlepath = g:myvim . '/bundle'

  if !filereadable(bundlepath . '/vundle/README.md')
    if !executable('git')
      echo "Can't autoinstall Vundle without git"
      return
    endif

    if !isdirectory(bundlepath)
      call mkdir(bundlepath, 'p')
    endif
    exec 'cd ' . bundlepath
    silent !git clone --depth 1 https://github.com/gmarik/vundle
    cd -

    echo "Installed Vundle, run :PluginInstall if desired"
  endif

  let &rtp .= ',' . bundlepath . '/vundle'
  call vundle#begin(bundlepath)
endfunc
