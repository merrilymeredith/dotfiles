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

func! vimrc#AutoSessionCheck() abort
  if strlen(v:servername) > 0 && match(v:servername, 'VIM') == -1
    let sessionfile = g:vimcache . "/session/" . tolower(v:servername) . ".vim"

    if filereadable(sessionfile)
      execute "source " . sessionfile
    endif
  endif
endfunc

func! vimrc#Ag(args) abort
  let orig_t_ti = &t_ti
  let orig_t_te = &t_te
  let orig_shellpipe = &shellpipe

  set t_ti= t_te=
  let &shellpipe = substitute(&shellpipe, '| tee', ' >', '')

  let grepargs = a:args == '' ? expand('<cword>') : a:args . join(a:000, ' ')

  try
    silent! execute "grep " . escape(grepargs, '|')
    copen

    let @/ = matchstr(a:args, "\\v(-)\@<!(\<)\@<=\\w+|['\"]\\zs.{-}\\ze['\"]")
    call feedkeys(":let &hlsearch=1 \| echo \<CR>", 'n')
  finally
    let &t_ti = orig_t_ti
    let &t_te = orig_t_te
    let &shellpipe = orig_shellpipe
  endtry
endfunc

func! vimrc#Gcd() abort
  let root = system('git rev-parse --show-toplevel 2>/dev/null')[:-2]
  if ! v:shell_error
    exec 'cd ' . root
  endif
  pwd
endfunc

func! vimrc#Hgcd() abort
  let root = system('hg root 2>/dev/null')[:-2]
  if ! v:shell_error
    exec 'cd ' . root
  endif
  pwd
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
