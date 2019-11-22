" Why this wrapper? vim :term sets $TERM to xterm but supports -256color and
" all the suggestions for fixing that involve changing $TERM for vim itself
" rather than just the subprocess.  Also since this runs in place we can
" switch back after.
func! tig#Tig(...) abort
  call term_start(
    \ ['/usr/bin/env', 'TERM=xterm-256color', 'tig'] + a:000,
    \ {'curwin': 1, 'term_name': join(['!tig'] + a:000, ' '), 'exit_cb': 'tig#TigExit'}
    \ )
endfunc

func! tig#TigBlame() abort
  call tig#Tig('blame', '+' . line('.'), '--', expand('%'))
endfunc

func! tig#TigExit(...) abort
  buffer #
endfunc
