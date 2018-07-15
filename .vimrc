" vim: et sts=2 sw=2
" vim: fdm=marker

set encoding=utf-8
scriptencoding utf-8

" on windows and not cygwin
let g:on_windows = (has('win32') || has('win64'))
let g:myvim      = $HOME . (g:on_windows ? '/vimfiles' : '/.vim')
let g:vimcache   = $HOME . '/.cache/vim'
let s:filename   = expand('<sfile>')

" Set up Vundle and plugins  {{{
  call vimrc#VundleInstallAndBegin()

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
  Plugin 'lifepillar/vim-mucomplete'

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

  Plugin 'powerman/vim-plugin-viewdoc'
  Plugin 'powerman/vim-plugin-AnsiEsc'

  let g:no_viewdoc_maps   = 1
  let g:no_viewdoc_abbrev = 1

  try
    execute 'source ' . s:filename . '.local-pre'
  catch
  endtry

  call vundle#end()
" }}}

" Key maps {{{
nnoremap <silent> <F1>   :Unite buffer<CR>
nnoremap <silent> <F2>   :VimFilerExplorer<CR>
noremap  <silent> <F4>   :noh<CR>
nnoremap <silent> <F5>   :GundoToggle<CR>
nnoremap <silent> <F8>   :TagbarToggle<CR>

nnoremap <leader>uw :Unite -quick-match -short-source-names window tab:no-current<CR>
nnoremap <leader>us :Unite -quick-match session<CR>
nnoremap <leader>uf :Unite -start-insert file_rec/async:!<CR>

" stop opening help by mistake
inoremap <F1> <ESC>

" let F4, :noh work as-is in insert mode
imap <F4> <C-O><F4>

" chdir to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

noremap <leader>pp :setlocal paste!<cr>

" faster window nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-\> <C-w>p

" navigate by on-screen lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" alt buffer
nnoremap gb <C-^>
nnoremap gB :ls<CR>:b<Space>

" Select last paste, in the same mode it was pasted in
nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

" Use ltag over tselect
nnoremap g<C-]> :call vimrc#Ltag(expand('<cword>'))<CR>

" clear all interestingwords with \\k since \K is ri.vim
nnoremap <silent> <leader><leader>k :call UncolorAllWords()<CR>

" use Ag for a recursive *
nnoremap g* :call ag#Ag('grep', '--literal ' . shellescape(expand("<cword>")))<CR>

" K: doc, gK: Doc w/o using syntax hints, gKK: doc current filename
nnoremap K   :call ViewDoc('doc', expand('<cword>'))<CR>
nnoremap gKK :call ViewDoc('doc', expand('%'))<CR>

" Tabular shortcuts
noremap <leader>ta :Tabularize first_arrow<CR>
noremap <leader>te :Tabularize first_eq<CR>
noremap <leader>tc :Tabularize first_colon<CR>
noremap <leader>tm :Tabularize methods<CR>

noremap <silent> <leader>a :call vimrc#AutoFmtToggle()<CR>

if exists("g:loaded_mucomplete")
  set shortmess+=c
  imap <Plug>MyCR <Plug>(MUcompleteCR)
  imap <cr> <Plug>MyCR
endif

" Command Aliases  {{{
command! -nargs=+ CAlias call vimrc#CommandAlias(<f-args>)
CAlias Q q
CAlias W w

" make these default to one window/buffer too
CAlias  doc      ViewDoc!
CAlias  help     ViewDocHelp!
CAlias  man      ViewDocMan!
CAlias  perldoc  ViewDocPerl!
"}}}

"}}}

" General settings  {{{
syntax on
filetype plugin indent on

set incsearch
set hlsearch
set ignorecase
set smartcase

if has('gui_running') || $LANG =~# 'UTF-8'
  set listchars=tab:⇥·,trail:◼,nbsp:◻,extends:⥂,precedes:⥃
  " eol:↩   not as useful as trail i think
  set fillchars=fold:∷,vert:│
else
  set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
endif

set linebreak
set showbreak=»\ 
if exists('&breakindent')
  set breakindent
  set breakindentopt+=sbr
endif

set virtualedit=block

set autoindent
set expandtab
set shiftwidth=2
set shiftround

set formatoptions=cqln1j
set backspace=indent,eol,start

set splitright splitbelow
set scrolloff=15
set sidescrolloff=10
set laststatus=2
set noshowmode
set showcmd
set wildmenu
set wildignorecase

set noerrorbells
if has('patch-7.4-793')
  set belloff=all
endif

set autowriteall

set ttimeout
set ttimeoutlen=25

set synmaxcol=200

set tags+=.tags

" Ignore compiled files and repositories
set wildignore=*.o,*~,*.pyc
if g:on_windows
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Don't assume to scan includes when autocompleting
set complete-=i complete-=t

set completeopt+=menuone
if has('patch-7.4-775')
  set completeopt+=noinsert
endif

" Never open with folds collapsed
set nofoldenable

" keep the junk out (imo)
set sessionoptions=buffers,curdir,localoptions

" Enable enhanced % matching in ruby
runtime macros/matchit.vim

for subdir in ['backup', 'tmp', 'undo']
  if !filewritable(g:vimcache . '/' . subdir)
    call mkdir(g:vimcache . '/' . subdir, 'p', 0700)
  endif
endfor

set backup
let &backupdir = g:vimcache . '/backup//,.'
let &directory = g:vimcache . '/tmp//,.'

if has('persistent_undo')
  set undofile
  let &undodir = g:vimcache . '/undo//,.'
endif

if g:on_windows
  set guifont=DejaVu_Sans_Mono:h10:cDEFAULT
  set linespace=0
elseif has('osx')
  set guifont=DejaVu\ Sans\ Mono:h11
else
  set guifont=DejaVu\ Sans\ Mono\ 10
endif

set go-=T go-=m go-=t "no toolbar, menu, tearoffs
" }}}

" Autocmds  {{{
augroup vimrc
  autocmd!

  " set and load a session based on servername
  autocmd VimEnter  * call vimrc#AutoSessionConfig()

  " complement to autowriteall
  autocmd FocusLost * silent! wa

  " Make paths when writing, as necessary
  autocmd BufWritePre * :call vimrc#MkNonExDir(expand('<afile>'), +expand('<abuf>'))

  " Jump to last known pos
  autocmd BufReadPost *
    \ if &filetype !~# 'mail\|^git\|^hg' && line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " Simple highlight conflict markers
  autocmd BufReadPost *
    \ syn match Error "^\(<\|>\||\)\1\{6,7}" |
    \ syn match Error "^=\{7,8}$"

  " double-click to edit in vimfiler
  autocmd FileType vimfiler nmap <buffer> <2-LeftMouse> <Plug>(vimfiler_edit_file)

  " Simplify noisy ltag output
  autocmd BufReadPost quickfix
    \ if w:quickfix_title =~# '^:ltag' |
      \ setl modifiable |
      \ silent exe ':%s/\^\\V\s*\|\\\$|.*//g' |
      \ setl nomodifiable |
    \ endif

  autocmd BufReadPost quickfix nmap <buffer> q <C-w>c

  " Neomutt changed their tmpfile pattern, ugh
  autocmd BufNewFile,BufRead neomutt-*-\w\+ setf mail
augroup END

" https://mjj.io/2015/01/27/encrypting-files-with-gpg-and-vim/
" hacked to work with vimwiki
augroup encrypted
  autocmd!
  autocmd BufReadPre,FileReadPre *.gpg,*.gpg.wiki setl noswapfile noundofile nobackup viminfo=
  autocmd BufReadPost *.gpg,*.gpg.wiki :sil %!GPG_TTY=/dev/tty gpg2 --decrypt 2> /dev/null
  autocmd BufWritePre *.gpg,*.gpg.wiki :sil %!GPG_TTY=/dev/tty gpg2 -se -a --default-recipient-self
  autocmd BufWritePost *.gpg,*.gpg.wiki :sil undo
augroup END
"}}}

" Perl type-specific settings  {{{
let perl_include_pod     = 1
let perl_sub_signatures  = 1
let perl_sync_dist       = 200

let g:perl_compiler_force_warnings = 0
let g:perl_tidy_equalprg           = executable('perltidy') ? 1 : 0
" }}}

" Plugin settings  {{{
">> vim-polyglot
let g:polyglot_disabled = ['vifm']

">> mucomplete
" enable and prefer local buffer before tags
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {'default': ['path', 'omni', 'c-n', 'tags', 'dict', 'uspl']}

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
let g:gundo_prefer_python3 = 1

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
    \ 'deffile' : g:myvim . '/ctags/perl.cnf'
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

" like autowrite, applies to any loaded session
let g:unite_source_session_enable_auto_save = 1

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
" }}}

" {{{ Commands
" Preview markdown mail -- I edit with headers so I box them in a code block.
command! MailPreview     enew | set bt=nofile | 0r # | exe 'norm! 0O```<Esc>}O```' | silent exe '%!mutt-md2html | mutt-html2txt' | 0
command! MailPreviewHTML enew | set bt=nofile | setf html | 0r # | exe 'norm! 0O```<Esc>}O```' | silent exe '%!mutt-md2html' | 0

" Diff unsaved buffer
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
" }}}

" Local stuff, finish up
try
  execute 'source ' . s:filename . '.local'
catch
endtry

if g:airline_powerline_fonts == 0 && (has('gui_running') || $LANG =~# 'UTF-8')
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
  " vertical bar in insert mode.
  if &term =~# '^\(xterm\|screen\|rxvt\)'
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[0 q"
    if exists("$TMUX")
      let &t_SI = "\ePtmux;" . substitute(&t_SI, "\e", "\e\e", 'g') . "\e\\"
      let &t_EI = "\ePtmux;" . substitute(&t_EI, "\e", "\e\e", 'g') . "\e\\"
    endif
  endif

  if $TERM =~# 'rxvt-unicode'
    set ttymouse=urxvt
    set mouse=a
    map <Esc>[7~ <Home>
    map <Esc>[8~ <End>
  endif

  if &t_Co == 256
    colorscheme jellybeans
  endif
endif
