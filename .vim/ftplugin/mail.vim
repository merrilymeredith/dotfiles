setl textwidth=72
setl formatoptions=jaw12tcql
setl spell

" Get right to composing the body:
if line('$') > 1
  :0
  :/^$/
  :normal 2] 
  :+1
  :exe 'startinsert'
endif

