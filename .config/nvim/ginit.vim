set number
set guifont=DejaVu\ Sans\ Mono:h10
set linespace=0

if exists("g:fvim_loaded")
  " sizes are inconsistent... doesn't autoadjust for dpi? vimresize event not
  " fired?
  if g:fvim_os == "windows"
    set guifont=DejaVu\ Sans\ Mono:h13
    FVimFontLineHeight "+1.0"
  elseif g:fvim_render_scale > 1.0
    set guifont=DejaVu\ Sans\ Mono:h11
  else
    set guifont=DejaVu\ Sans\ Mono:h10
  endif

  " These take a ton of scroll events to trigger, it's easier with the touchpad?
  nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>

  nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

