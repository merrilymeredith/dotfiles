" Add match for 'fun' from Function::Parameters
syn match perlFunction +\<fun\>\_s*+ nextgroup=perlSubName

" Add match for =method from Pod::Weaver
syn match podCommand "^=method" contained nextgroup=podCmdText contains=@NoSpell

