" based on
" https://mjj.io/2015/01/27/encrypting-files-with-gpg-and-vim/
" hacked to work with vimwiki
" moved to ftplugin

setl noswapfile noundofile nobackup viminfo=

sil %!GPG_TTY=/dev/tty gpg2 --decrypt 2>/dev/null

augroup GPGWriteEncrypted
  autocmd!
  autocmd BufWritePre *.gpg,*.gpg.wiki :sil %!GPG_TTY=/dev/tty gpg2 -se -a --default-recipient-self 2>/dev/null
  autocmd BufWritePost *.gpg,*.gpg.wiki :sil undo
augroup END
