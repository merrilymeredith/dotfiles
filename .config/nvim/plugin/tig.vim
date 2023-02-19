func! tig#Tig(...) abort
  enew
  setl nonumber
  call termopen(["tig"] + a:000, {'on_exit': 'tig#TigExit'})
endfunc

func! tig#TigBlame() abort
  call tig#Tig('blame', '+' . line('.'), '--', expand('%'))
endfunc

func! tig#TigExit(...) abort
  buffer #
endfunc

command! -nargs=* -complete=file Tig      call tig#Tig(<f-args>)
command!                         TigBlame call tig#TigBlame()
command!                         TigLog   call tig#Tig('log', '-p', '--', expand('%'))

