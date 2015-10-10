
" I would use symlinks but cygwin likes to fumble them
runtime contrib/carp.vim
runtime contrib/highlight-all-pragmas.vim
runtime contrib/moose.vim
runtime contrib/method-signatures.vim
runtime contrib/test-more.vim
runtime contrib/try-tiny.vim

" Add match for 'fun' from Function::Parameters
syn match perlFunction +\<fun\>\_s*+ nextgroup=perlSubName
