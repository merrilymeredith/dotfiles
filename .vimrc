" vim: et sts=2 sw=2
" vim: fdm=marker

set nocompatible

" on windows and not cygwin
let g:on_windows = (has('win32') || has('win64'))
let s:filename   = expand('<sfile>')

" Set up Vundle and plugins  {{{
  call vimrc#VundleInstall()

  if g:on_windows
    set rtp+=~/vimfiles/bundle/vundle/
    call vundle#begin('~/vimfiles/bundle')
  else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()
  endif

  Plugin 'gmarik/vundle'

  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'vasconcelloslf/vim-interestingwords'

  Plugin 'editorconfig/editorconfig-vim'

  Plugin 'Shougo/vimproc.vim'
  Plugin 'Shougo/unite.vim'
  Plugin 'Shougo/vimfiler.vim'
  Plugin 'Shougo/unite-session'
  Plugin 'sjl/gundo.vim'
  Plugin 'majutsushi/tagbar'
  Plugin 'rking/ag.vim'

  Plugin 'godlygeek/tabular'
  Plugin 'tomtom/tcomment_vim'
  Plugin 'tpope/vim-unimpaired'
  Plugin 'tpope/vim-endwise'

  Plugin 'vimwiki/vimwiki'

  Plugin 'tpope/vim-fugitive'
  Plugin 'ludovicchabant/vim-lawrencium'

  Plugin 'Shougo/vinarise.vim'
  Plugin 'asciidoc/vim-asciidoc'
  Plugin 'vim-perl/vim-perl'
  Plugin 'sheerun/vim-polyglot'
  Plugin 'yko/mojo.vim'
  Plugin 'slashmili/alchemist.vim'
  Plugin 'nathangrigg/vim-beancount'
  Plugin 'chr4/sslsecure.vim'

  Plugin 'powerman/vim-plugin-viewdoc'
  Plugin 'powerman/vim-plugin-AnsiEsc'

  let g:no_viewdoc_maps = 1

  try
    execute 'source ' . s:filename . '.local-pre'
  catch
  endtry

  call vundle#end()
" }}}


" Key maps {{{
nmap <silent> <F1>   :Unite buffer<CR>
nmap <silent> <C-F1> :Unite -quick-match -short-source-names window tab:no-current<CR>
nmap <silent> <A-F1> :Unite session<CR>
nmap <silent> <F2>   :VimFilerExplorer<CR>
nmap <silent> <C-F2> :Unite -start-insert file_rec/async:!<CR>
map  <silent> <F4>   :noh<CR>
nmap <silent> <F5>   :GundoToggle<CR>
nmap <silent> <F8>   :TagbarToggle<CR>

" stop opening help by mistake
imap <F1> <ESC>

" let F4, :noh work as-is in insert mode
imap <F4> <C-O><F4>

" chdir to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <leader>pp :setlocal paste!<cr>

" faster window nav
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-\> <C-w>p

" navigate by on-screen lines
map j gj
map k gk

" alt buffer
nmap gb <C-^>
nmap gB :ls<CR>:b<Space>

" Select last paste
map gV `[v`]

" clear all interestingwords with \\k since \K is ri.vim
nmap <silent> <leader><leader>k :call UncolorAllWords()<CR>

" use Ag for a recursive *
nmap <leader>* :call ag#Ag('grep', '--literal ' . shellescape(expand("<cword>")))<CR>

" K: doc, gK: Doc w/o using syntax hints, gKK: doc current filename
nmap K   :call ViewDoc('doc', expand('<cword>'))<CR>
nmap gKK :call ViewDoc('doc', expand('%'))<CR>

" Tabular shortcuts
map <leader>ta :Tabularize first_arrow<CR>
map <leader>te :Tabularize first_eq<CR>
map <leader>tc :Tabularize first_colon<CR>
map <leader>tm :Tabularize methods<CR>

map <silent> <leader>a :call vimrc#AutoFmtToggle()<CR>

cabbr Q q
cabbr W w
"}}}


" General settings  {{{
syntax on
filetype plugin indent on

set encoding=utf-8

set incsearch
set hlsearch
set ignorecase
set smartcase

if has('gui_running') || $LANG =~ 'UTF-8'
  set listchars=tab:⇥·,trail:◼,nbsp:◻
  " eol:↩   not as useful as trail i think
  set fillchars=fold:∷,vert:│
endif

if exists('&breakindent')
  set bri
  set briopt+=sbr
endif

set virtualedit=block

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

set formatoptions=cqln1
set backspace=indent,eol,start

if has('patch-7.3-541')
  " Can unwrap this once I don't have to deal with ubuntu 12.04
  set formatoptions+=j
endif

set splitright splitbelow
set scrolloff=15
set sidescrolloff=10
set ruler
set noshowmode
set showcmd
set wildmenu
set wildignorecase

set ttimeout
set ttimeoutlen=200

set tags+=.tags

" Ignore compiled files and repositories
set wildignore=*.o,*~,*.pyc
if g:on_windows
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Enable enhanced % matching in ruby
runtime macros/matchit.vim

" Don't assume to scan includes when autocompleting
set complete-=i

" Never open with folds collapsed
set nofoldenable

set linebreak
set showbreak=»\ 

" keep the junk out (imo)
set sessionoptions=buffers,curdir,localoptions

" Superseded by vim-airline
"set statusline=%f%m%r%h%w\ %y\ %=%l,%c\ %p%%\ %L
set laststatus=2

if g:on_windows
  let $MYVIM=$HOME.'/vimfiles'

  if !filewritable( $MYVIM . '/var' )
    silent execute '!mkdir "'.$HOME.'\vimfiles\var"'
  endif
  if !filewritable( $MYVIM. '/var/backup' )
    silent execute '!mkdir "'.$HOME.'\vimfiles\var\backup"'
  endif
  if !filewritable( $MYVIM . '/var/tmp' )
    silent execute '!mkdir "'.$HOME.'\vimfiles\var\tmp"'
  endif
  if !filewritable( $MYVIM . '/var/undo' )
    silent execute '!mkdir "'.$HOME.'\vimfiles\var\undo"'
  endif

else
  let $MYVIM=$HOME.'/.vim'

  if !filewritable( $MYVIM . '/var/backup' )
    silent execute '!mkdir -p "'.$MYVIM.'/var/backup"'
  endif
  if !filewritable( $MYVIM . '/var/tmp' )
    silent execute '!mkdir "'.$MYVIM.'/var/tmp"'
  endif
  if !filewritable( $MYVIM . '/var/undo' )
    silent execute '!mkdir "'.$MYVIM.'/var/undo"'
  endif

endif

if g:on_windows
  set guifont=DejaVu_Sans_Mono:h10:cDEFAULT
  set linespace=0
elseif has('osx')
  set guifont=DejaVu\ Sans\ Mono:h11
else
  set guifont=DejaVu\ Sans\ Mono\ 10
endif

set guioptions-=T "no toolbar, menu, tearoffs
set guioptions-=m
set guioptions-=t

set backupdir=$MYVIM/var/backup//,.
set directory=$MYVIM/var/tmp//,.

set backup
set autowriteall

if has('persistent_undo')
  set undofile
  set undodir=$MYVIM/var/undo//,.
endif
" }}}


" Autocmds  {{{
function! AutoSessionConfig()
  if strlen(v:servername) > 0 && match(v:servername, 'VIM') == -1
    let g:unite_source_session_default_session_name = tolower(v:servername)
    let g:unite_source_session_enable_auto_save = 1

    UniteSessionLoad
  endif
endfunction

augroup vimrc
  autocmd!

  " set and load a session based on servername
  autocmd VimEnter  * call AutoSessionConfig()

  " complement to autowriteall
  autocmd FocusLost * silent! wa

  " Jump to last known pos
  autocmd BufReadPost *
    \ if &filetype !~ 'mail\|^git\|^hg' && line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " double-click to edit in vimfiler
  autocmd FileType vimfiler nmap <buffer> <2-LeftMouse> <Plug>(vimfiler_edit_file)

augroup END

" Make paths when writing, as necessary
augroup AutoMkdir
  autocmd!
  autocmd BufWritePre * :call vimrc#MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" https://mjj.io/2015/01/27/encrypting-files-with-gpg-and-vim/
augroup encrypted
  autocmd!
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup viminfo=
  autocmd BufReadPost *.gpg :%!GPG_TTY=/dev/tty gpg2 --decrypt 2> /dev/null
  autocmd BufWritePre *.gpg :%!GPG_TTY=/dev/tty gpg2 -se -a --default-recipient-self
  autocmd BufWritePost *.gpg u
augroup END
"}}}


" Perl type-specific settings  {{{
let perl_include_pod = 1
let perl_sub_signatures = 1
let perl_sync_dist = 200
" }}}


" Plugin settings  {{{

">> Vimwiki
let g:vimwiki_list = [
  \ {
    \ 'path': '~/vimwiki/',
    \ 'auto_tags': 1, 'auto_toc': 1, 'automatic_nested_syntaxes': 1
  \ },
  \ {
    \ 'path': '~/Documents/SpiderOak Hive/vimwiki',
    \ 'auto_tags': 1, 'auto_toc': 1, 'automatic_nested_syntaxes': 1
  \ }
\ ]
let g:vimwiki_use_mouse = 1

">> Viewdoc
let g:viewdoc_open = 'topleft new'
let g:viewdoc_perldoc_format = 'ansi'
let g:viewdoc_winwidth_max = 100

">> Gundo
" I prefer python3 on windows if I have to use it. Needs a dll in path.
if g:on_windows
  let g:gundo_prefer_python3 = 1
endif

">> Tagbar
if g:on_windows
  if executable('ctags') == 0
    " if i haven't installed from chocolatey...
    let g:tagbar_ctags_bin = 'C:\Users\mhoward\bin\ctags.exe'
  endif
endif

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_width = 30

" adapted from https://gist.github.com/jbolila/7598018
let g:tagbar_type_perl = {
    \ 'ctagstype'   : 'Perl',
    \ 'kinds' : [
        \ 'p:packages:1:0',
        \ 'u:uses:1:0',
        \ 'r:requires:1:0',
        \ 'e:extends',
        \ 'w:roles',
        \ 'o:ours:1:0',
        \ 'c:constants:1:0',
        \ 'f:formats:1:0',
        \ 'a:attributes',
        \ 'm:methods',
        \ 's:subroutines',
        \ 'x:around',
        \ 'l:aliases',
        \ 'd:pod:1:0',
    \ ],
    \ 'deffile' : '$MYVIM/ctags/perl.cnf'
\ }

let g:tagbar_type_elixir = {
  \ 'ctagstype' : 'Elixir',
  \ 'kinds' : [
    \ 'm:modules:1:0',
    \ 'r:records',
    \ 'f:functions',
    \ 'a:macros',
    \ 'o:operators',
    \ 'p:protocols',
    \ 'i:implementations',
    \ 'd:delegates',
    \ 'c:callbacks',
    \ 'e:exceptions',
  \ ],
\ }

">> Unite
try
  " call unite#filters#matcher_default#use(['matcher_fuzzy'])
  call unite#filters#sorter_default#use(['sorter_rank'])

  call unite#custom#profile('default', 'context', {'winheight': 10})
catch
endtry

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  
  let g:unite_source_rec_async_command = ['ag', '-f', '--nocolor', '--nogroup', '-g', '']
endif

">> vimfiler
let g:vimfiler_as_default_explorer = 1

">> Airline
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 0

let g:airline#extensions#tabline#enabled          = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_nr_type      = 1
let g:airline#extensions#tabline#buffer_nr_show   = 1
let g:airline#extensions#tabline#formatter        = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#buffers_label    = 'BUF'
let g:airline#extensions#tabline#tabs_label       = 'TAB'
let g:airline#extensions#tabline#left_sep         = ' '
let g:airline#extensions#tabline#left_alt_sep     = ' '
let g:airline#extensions#tabline#right_sep        = ' '
let g:airline#extensions#tabline#right_alt_sep    = ' '

let g:airline#extensions#tabline#ignore_bufadd_pat =
  \ '\c\v^__gundo|^__tagbar|^vimfiler|^[doc\d+\]$'
let g:airline#extensions#tabline#excludes = [
  \ g:airline#extensions#tabline#ignore_bufadd_pat,
  \ ]

let g:airline#extensions#branch#format = 2

">> interestingwords
" These are jellybeans colors and some complements
let g:interestingWordsGUIColors = ['#C4A258', '#D8AD4C', '#6AADA0', '#71B9F8', '#A037B0', '#CF6A4C']
let g:interestingWordsRandomiseColors = 1

">> neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

"Required to get ruby omni
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" allow module completion from CPAN when combined with perlomni
"let g:neocomplcache_omni_patterns.perl = '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
" seems like overkill

if !exists('g:neocomplcache_filename_include_exprs')
  let g:neocomplcache_filename_include_exprs = {}
endif

"help scan into "use" statements
let g:neocomplcache_filename_include_exprs.perl = 'fnamemodify(substitute(v:fname, "/", "::", "g"), ":r")'

" }}}


" {{{ Commands
" Preview markdown mail -- I edit with headers so I box them in a code block.
command! MailPreview     enew | set bt=nofile | 0r # | exe 'norm 0O```<Esc>}O```' | silent exe '%!mutt-md2html | mutt-html2txt' | 0
command! MailPreviewHTML enew | set bt=nofile | 0r # | exe 'norm 0O```<Esc>}O```' | silent exe '%!mutt-md2html' | 0

if !exists(":DiffOrig")
  " Diff unsaved buffer
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
" }}}

" Local stuff, finish up
try
  execute 'source ' . s:filename . '.local'
catch
endtry

if g:airline_powerline_fonts == 0 && (has('gui_running') || $LANG =~ 'UTF-8')
  let g:airline_left_sep  = '▒'
  let g:airline_right_sep = g:airline_left_sep
endif

if has('gui_running')
  set number
  set background=dark

  set columns=120 lines=40

  set guicursor+=a:blinkwait1000-blinkon1200-blinkoff250

  colorscheme jellybeans
else
  if $TERM =~ '^screen'
    if $TERM == 'screen-bce'
      set t_Co=256
    endif

    set mouse=a
  endif

  " vertical bar in insert mode.
  if &term =~ '^\(xterm\|screen\|rxvt\)'
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[0 q"
    if exists("$TMUX")
      let &t_SI = "\ePtmux;" . substitute(&t_SI, "\e", "\e\e", 'g') . "\e\\"
      let &t_EI = "\ePtmux;" . substitute(&t_EI, "\e", "\e\e", 'g') . "\e\\"
    endif
  endif

  if $TERM =~ 'rxvt-unicode'
    set ttymouse=urxvt
    set mouse=a
    map <Esc>[7~ <Home>
    map <Esc>[8~ <End>
  endif

  if &t_Co == 256
    colorscheme jellybeans
  endif
endif

