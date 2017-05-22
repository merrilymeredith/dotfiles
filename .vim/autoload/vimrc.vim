
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

function! vimrc#VundleInstall() abort
  " on windows and not cygwin
  let l:on_windows = (has('win32') || has('win64'))

  let l:vundle_readme = expand(l:on_windows
    \ ? '~/vimfiles/bundle/vundle/README.md'
    \ : '~/.vim/bundle/vundle/README.md')

  if !filereadable(l:vundle_readme)
    if !executable('git')
      echo "Can't autoinstall Vundle without git"
      return
    endif

    if l:on_windows == 0
      silent !mkdir -p ~/.vim/bundle
      silent !git clone --depth 1 https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    else
      silent execute '!mkdir "'. $HOME .'\vimfiles\bundle"'
      silent execute '!git clone --depth 1 https://github.com/gmarik/vundle "'. $HOME .'\vimfiles\bundle\vundle"'
    endif

    echo "Installed Vundle, run :PluginInstall if desired"
  endif

endfunction
