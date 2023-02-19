command! -nargs=+ CAlias call vimrc#CommandAlias(<f-args>)

command! Gcd call vimrc#Gcd()
command! Hgcd call vimrc#Hgcd()

command! SyntaxCompleteOn setl omnifunc=syntaxcomplete#Complete

command! Mksession execute "mksession! " . v:this_session
command! PruneSession call vimrc#PruneSession()

command! -nargs=* -complete=file Tig      call tig#Tig(<f-args>)
command!                         TigBlame call tig#TigBlame()
command!                         TigLog   call tig#Tig('log', '-p', '--', expand('%'))

" Preview markdown mail -- I edit with headers so I box them in a code block.
command! MailPreview     enew | set bt=nofile | 0r # | exe 'norm! 0O```<Esc>}O```' | silent exe '%!mutt-md2html | mutt-html2txt' | 0
command! MailPreviewHTML enew | set bt=nofile | setf html | 0r # | exe 'norm! 0O```<Esc>}O```' | silent exe '%!mutt-md2html' | 0

command! -nargs=* -complete=file Grep call vimrc#Grep(<f-args>)
CAlias Ag Grep
CAlias grep Grep

CAlias Q q
CAlias Qa qa
CAlias W w

CAlias gcd Gcd
CAlias hgcd Hgcd

" make these default to one window/buffer too
CAlias  doc      ViewDoc!
CAlias  help     ViewDocHelp!
CAlias  man      ViewDocMan!
CAlias  perldoc  ViewDocPerl!

