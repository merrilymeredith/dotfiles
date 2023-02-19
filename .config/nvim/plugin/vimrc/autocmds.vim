augroup vimrc
  autocmd!

  autocmd TermOpen * startinsert

  autocmd WinLeave * if !pumvisible() | stopinsert | endif

  " complement to autowriteall
  autocmd FocusLost * silent! wa

  " Make paths when writing, as necessary
  autocmd BufWritePre * :call vimrc#MkNonExDir(expand('<afile>'), +expand('<abuf>'))

  if ! &diff
    " set and load a session based on servername
    autocmd VimEnter * nested call vimrc#AutoSessionCheck()

    " Jump to last known pos
    autocmd BufReadPost *
      \ if &filetype !~# 'mail\|^git\|^hg' && line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " Simple highlight conflict markers
    autocmd BufReadPost *
      \ match Error "^\([<>|]\)\{7} \@=\|^=\{7}$"
  endif

  " Simplify noisy ltag output
  autocmd BufReadPost quickfix
    \ if w:quickfix_title =~# '^:ltag' |
      \ setl modifiable |
      \ silent exe ':%s/\^\\V\s*\|\\\$|.*//g' |
      \ setl nomodifiable |
    \ endif

  " easy close quickfix
  autocmd BufReadPost quickfix nmap <buffer> q <C-w>c

  " Neomutt changed their tmpfile pattern, ugh
  autocmd BufNewFile,BufRead neomutt-*-\w\+ setf mail
augroup END

" https://mjj.io/2015/01/27/encrypting-files-with-gpg-and-vim/
" hacked to work with vimwiki
augroup encrypted
  autocmd!
  autocmd BufReadPre,FileReadPre *.gpg,*.gpg.* setl noswapfile noundofile nobackup viminfo=
  autocmd BufReadPost *.gpg,*.gpg.* call vimrc#SafeFilterFile('gpg2 -d')
  autocmd BufWritePre *.gpg,*.gpg.* call vimrc#SafeFilterFile('gpg2 -se -a --default-recipient-self')
  autocmd BufWritePost *.gpg,*.gpg.* :sil undo
augroup END

