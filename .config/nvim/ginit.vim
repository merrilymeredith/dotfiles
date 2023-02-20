
set number
set guifont=DejaVu\ Sans\ Mono:h10
set linespace=0

if exists("g:fvim_loaded")
  set guifont=DejaVu\ Sans\ Mono:h12
  FVimFontLineHeight "+1.0"
  " FVimFontAutoSnap v:false

  nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

