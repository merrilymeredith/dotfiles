
set number
set guifont=DejaVu\ Sans\ Mono:h10
set linespace=0

if exists("g:fvim_loaded")
  set guifont=DejaVu\ Sans\ Mono:h13
  FVimFontLineHeight "+1.0"

  nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

