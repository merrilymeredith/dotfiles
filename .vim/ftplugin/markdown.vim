runtime ftplugin/text.vim
setl equalprg=pandoc\ -f\ markdown\ -t\ markdown

let b:markdown_autohtml = 0

function! s:autohtml() abort
  if get(b:, 'markdown_autohtml', 0)
    silent !md2html -o "%:p.html" "%:p"
  endif
endfunction

augroup Markdown
  autocmd!
  autocmd BufWritePost <buffer> call s:autohtml()
augroup END
