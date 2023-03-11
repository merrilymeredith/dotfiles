" https://mjj.io/2015/01/27/encrypting-files-with-gpg-and-vim/
" hacked to work with vimwiki
augroup encrypted
  autocmd!
  autocmd BufReadPre,FileReadPre *.gpg,*.gpg.* setl noswapfile noundofile nobackup viminfo=
  autocmd BufReadPost *.gpg,*.gpg.* call vimrc#SafeFilterFile('gpg2 -d')
  autocmd BufWritePre *.gpg,*.gpg.* call vimrc#SafeFilterFile('gpg2 -se -a --default-recipient-self')
  autocmd BufWritePost *.gpg,*.gpg.* :sil undo
augroup END

