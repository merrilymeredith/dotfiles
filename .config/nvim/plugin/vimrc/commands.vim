command! SyntaxCompleteOn setl omnifunc=syntaxcomplete#Complete

command! Mksession execute "mksession! " . v:this_session

" Preview markdown mail -- I edit with headers so I box them in a code block.
command! MailPreview     enew | set bt=nofile | 0r # | exe 'norm! 0O```<Esc>}O```' | silent exe '%!mutt-md2html | mutt-html2txt' | 0
command! MailPreviewHTML enew | set bt=nofile | setf html | 0r # | exe 'norm! 0O```<Esc>}O```' | silent exe '%!mutt-md2html' | 0
