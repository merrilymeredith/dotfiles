
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
  let l:vundle_readme = expand(g:on_windows
    \ ? '~/vimfiles/bundle/vundle/README.md'
    \ : '~/.vim/bundle/vundle/README.md')

  if !filereadable(l:vundle_readme)
    if !executable('git')
      echo "Can't autoinstall Vundle without git"
      return
    endif

    if g:on_windows == 0
      silent !mkdir -p ~/.vim/bundle
      silent !git clone --depth 1 https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    else
      silent execute '!mkdir "'. $HOME .'\vimfiles\bundle"'
      silent execute '!git clone --depth 1 https://github.com/gmarik/vundle "'. $HOME .'\vimfiles\bundle\vundle"'
    endif

    echo "Installed Vundle, run :PluginInstall if desired"
  endif

  if g:on_windows
    set rtp+=~/vimfiles/bundle/vundle/
    call vundle#begin('~/vimfiles/bundle')
  else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()
  endif
endfunc
