if executable('shfmt')
  let &l:equalprg = "shfmt -i " . &shiftwidth
endif
