setl textwidth=72
setl formatoptions=jaw12tcql
setl spell

" http://cedricduval.free.fr/download/mail.vim
function! Mail_Erase_Sig()
  " search for the signature pattern (takes into account signature delimiters
  " from broken mailers that forget the space after the two dashes)
  let i = 0
  while ((i <= line('$')) && (getline(i) !~ '^> *-- \=$'))
    let i = i + 1
  endwhile

  " if found, then
  if (i != line('$') + 1)
    " first, look for our own signature, to avoid deleting it
    let j = i
    while (j < line('$') && (getline(j + 1) !~ '^-- $'))
      let j = j + 1
    endwhile

    " second, search for the last non empty (non sig) line
    while ((i > 0) && (getline(i - 1) =~ '^\(>\s*\)*$'))
      let i = i - 1
    endwhile

    " third, delete those lines plus the signature
    exe ':'.i.','.(j - 1).'d'
  endif
endfunction

call Mail_Erase_Sig()

" Get right to composing the body:
if line('$') > 1
  :normal gg}o
  :startinsert
endif
