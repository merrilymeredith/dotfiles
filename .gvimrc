set number

set go-=T go-=m go-=t "no toolbar, menu, tearoffs

set guicursor+=a:blinkwait1000-blinkon1200-blinkoff250

if g:airline_powerline_fonts == 0
  if g:on_windows
    set guifont=DejaVu_Sans_Mono:h10:cDEFAULT
    set linespace=0
  elseif has('osx')
    set guifont=DejaVu\ Sans\ Mono:h11
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
  endif

  let g:airline_left_sep  = '▒'
  let g:airline_right_sep = '▒'
endif

if !get(s:, 'vimrc_window_sized', 0)
  set columns=120 lines=40
  let s:vimrc_window_sized = 1
endif
