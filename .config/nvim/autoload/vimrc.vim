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

