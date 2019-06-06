compiler perl

if exists('g:perl_tidy_equalprg') && g:perl_tidy_equalprg
  setlocal equalprg=perltidy\ -q
endif
