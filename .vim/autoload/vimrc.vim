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

func! vimrc#Grep(...) abort
  let pattern = get(a:000, 0, expand('<cword>'))
  let cmd = join([&grepprg, shellescape(pattern)] + a:000[1:], ' ')

  cgetexpr system(cmd)
  call setqflist([], 'a', {"title": cmd})
  let @/ = '\v' . pattern
  copen
  cfirst
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

if has('perl')
  func! vimrc#PruneSession() abort
    perl <<END_PERL
      my @bufs =
        grep { !-e $_->Name || -d _ || (-M _ >= 30) }
        grep { $_->Name } VIM::Buffers();

      while (my $b = shift @bufs) {
        VIM::Msg 'pruned: ' . $b->Name, 'Comment';
        VIM::DoCommand 'bwipeout ' . $b->Number;
      }
      VIM::DoCommand 'bprev'
        unless $curbuf->Name;
END_PERL
  endfunc
endif

func! vimrc#PrepDir(path) abort
  if !filewritable(a:path)
    call mkdir(a:path, 'p', 0700)
  endif
endfunc

if has('ruby')
  func! s:PruneFiles(path, days) abort
    ruby <<END_RUBY
      require 'pathname'

      (path, days) = VIM.evaluate('[a:path, a:days]')
      sunset       = Time.now - (days * 86400)

      Pathname(path).realpath.each_child do |file|
        file.delete if file.mtime < sunset
      end
END_RUBY
  endfunc
else
  func! s:PruneFiles(path, days) abort
  endfunc
endif

func! vimrc#PruneFiles(path, days) abort
  call s:PruneFiles(a:path, a:days)
endfunc

