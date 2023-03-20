" vim: et sts=2 sw=2
" vim: fdm=marker

set encoding=utf-8
scriptencoding utf-8

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" on windows and not cygwin
let g:on_windows = (has('win32') || has('win64'))
let g:myvim      = $HOME . (g:on_windows ? '/vimfiles' : '/.vim')
let g:vimcache   = $HOME . '/.cache/vim'
let s:filename   = expand('<sfile>')

" Set up plug and plugins  {{{
  call plug#begin(g:myvim . '/bundle')

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'lfv89/vim-interestingwords'
  Plug 'nathanaelkane/vim-indent-guides'

  Plug 'ciaranm/securemodelines'
  Plug 'editorconfig/editorconfig-vim'

  Plug 'wsdjeg/vim-fetch'
  Plug 'tpope/vim-vinegar'
  Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
  Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

  Plug 'godlygeek/tabular'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-unimpaired'
  Plug 'kshenoy/vim-signature'
  Plug 'lifepillar/vim-mucomplete'
  Plug 'tpope/vim-endwise'
  Plug 'kana/vim-textobj-user'
  Plug 'glts/vim-textobj-comment'

  Plug 'vimwiki/vimwiki'

  Plug 'Shougo/vinarise.vim'
  Plug 'asciidoc/vim-asciidoc'
  Plug 'vim-perl/vim-perl', {'branch': 'dev'}
  Plug 'sheerun/vim-polyglot'
  Plug 'yko/mojo.vim'

  Plug 'powerman/vim-plugin-viewdoc'

  let g:no_viewdoc_abbrev = 1
  let g:polyglot_disabled = ['autoindent', 'sensible', 'vifm', 'perl', 'go']

  try
    execute 'source ' . s:filename . '.local-pre'
  catch
  endtry

  call plug#end()
" }}}

" Key maps {{{
nnoremap <silent> <F2>   :20Lexplore<CR>
nnoremap <silent> <F3>   n
nnoremap <silent> <S-F3> N
noremap  <silent> <F4>   :let v:hlsearch = !v:hlsearch<CR>
nnoremap <silent> <F5>   :UndotreeToggle<CR>
nnoremap <silent> <F8>   :TagbarToggle<CR>

" let F4, :noh work as-is in insert mode
imap <F4> <C-O><F4>

cmap <F3> <CR>

" chdir to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

noremap <leader>pp :setlocal paste!<cr>

noremap <leader>cc :MUcompleteAutoToggle<cr>

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

" mark line
nmap <leader>l V<leader>k

" use Grep for a recursive *
nnoremap g* :Grep<CR>

" K: doc, gKK: doc current filename
nnoremap gKK :call ViewDoc('doc', expand('%:p'))<CR>

" Tabular shortcuts
noremap <leader>ta :Tabularize first_arrow<CR>
noremap <leader>te :Tabularize first_eq<CR>
noremap <leader>tc :Tabularize first_colon<CR>
noremap <leader>tm :Tabularize methods<CR>

noremap <silent> <leader>a :call vimrc#AutoFmtToggle()<CR>

" Commands & Aliases  {{{
command! -nargs=+ CAlias call vimrc#CommandAlias(<f-args>)

command! Gcd call vimrc#Gcd()
command! Hgcd call vimrc#Hgcd()

command! SyntaxCompleteOn setl omnifunc=syntaxcomplete#Complete

command! Mksession execute "mksession! " . v:this_session
command! PruneSession call vimrc#PruneSession()

command! -nargs=* -complete=file Tig      call tig#Tig(<f-args>)
command!                         TigBlame call tig#TigBlame()
command!                         TigLog   call tig#Tig('log', '-p', '--', expand('%'))

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
"}}}

"}}}

" General settings  {{{
set background=dark

set hlsearch
set ignorecase
set smartcase

if has('gui_running') || $LANG =~# 'UTF-8'
  let &listchars = "tab:⇥·,trail:◼,nbsp:◻,extends:»,precedes:«"
  let &fillchars = "fold: ,vert:│"
else
  let &listchars = "tab:>-,trail:-,nbsp:%,extends:»,precedes:«"
  let &fillchars = "fold: "
endif

set linebreak
let &showbreak = "» "
set breakindent
set breakindentopt=min:66,shift:2

set virtualedit=block

set autoindent
set smarttab
set expandtab
set shiftwidth=2
set shiftround

set formatoptions=cqln1j
if has("patch-8.1.0360")
  set diffopt+=algorithm:patience
endif

set splitright splitbelow
set scrolloff=15
set sidescrolloff=10
set laststatus=2
set noshowmode
set wildignorecase
set shortmess+=c

set noerrorbells
set belloff=all

set autowriteall
set autoread

set ttimeoutlen=25

set synmaxcol=350

set tags+=.tags,./.tags;

" Ignore compiled files and repositories
set wildignore=*.o,*~,*.pyc
if g:on_windows
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Don't assume to scan includes when autocompleting
set complete-=i complete-=t

set completeopt+=menuone,noselect

" Never open with folds collapsed
set nofoldenable

" keep the junk out (imo)
set sessionoptions=buffers,curdir,localoptions

" Enable enhanced % matching in ruby
runtime macros/matchit.vim

for subdir in ['backup', 'tmp', 'undo']
  call vimrc#PrepDir(g:vimcache . '/' . subdir)
  " call vimrc#PruneFiles(g:vimcache . '/' . subdir, 60)
endfor
call vimrc#PrepDir(g:vimcache . '/session')

set backup
let &backupdir = g:vimcache . '/backup//,.'
let &directory = g:vimcache . '/tmp//,.'

if has('persistent_undo')
  set undofile
  let &undodir = g:vimcache . '/undo//,.'
endif

if executable('ag')
  let &grepprg = "ag --vimgrep"
  set grepformat^=%f:%l:%c:%m,%f
  set errorformat+=%f
endif

let g:jellybeans_overrides = {
    \ 'SignColumn': {'ctermbg': 235, 'guibg':'222222'},
  \ }

colorscheme jellybeans
" }}}

" Autocmds  {{{
augroup vimrc
  autocmd!

  autocmd WinLeave * if !pumvisible() | stopinsert | endif

  " complement to autowriteall
  autocmd FocusLost * silent! wa

  " Make paths when writing, as necessary
  autocmd BufWritePre * :call vimrc#MkNonExDir(expand('<afile>'), +expand('<abuf>'))

  if ! &diff
    " set and load a session based on servername
    autocmd VimEnter * nested call vimrc#AutoSessionCheck()

    " Jump to last known pos
    autocmd BufReadPost *
      \ if &filetype !~# 'mail\|^git\|^hg' && line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " Simple highlight conflict markers
    autocmd BufReadPost *
      \ match Error "^\([<>|]\)\{7} \@=\|^=\{7}$"
  endif

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

" clear defaults.vim 'jump to last known pos'
augroup vimStartup | au! | augroup END

" https://mjj.io/2015/01/27/encrypting-files-with-gpg-and-vim/
" hacked to work with vimwiki
augroup encrypted
  autocmd!
  autocmd BufReadPre,FileReadPre *.gpg,*.gpg.* setl noswapfile noundofile nobackup viminfo=
  autocmd BufReadPost *.gpg,*.gpg.* call vimrc#SafeFilterFile('gpg2 -d')
  autocmd BufWritePre *.gpg,*.gpg.* call vimrc#SafeFilterFile('gpg2 -se -a --default-recipient-self')
  autocmd BufWritePost *.gpg,*.gpg.* :sil undo
augroup END
"}}}

" Perl type-specific settings  {{{
let perl_include_pod     = 1
let perl_sub_signatures  = 1
let perl_sync_dist       = 200

let g:perl_compiler_force_warnings = 0
" }}}

" Plugin settings  {{{
let g:plug_threads = 3

let g:netrw_altfile = 1
let g:netrw_use_errorwindow = 0

">> mucomplete
" enable and prefer local buffer before tags
let g:mucomplete#completion_delay = 300
let g:mucomplete#chains = {
  \ 'default': ['path', 'c-n', 'omni', 'tags', 'dict', 'uspl'],
  \}

">> Vimwiki
let g:vimwiki_auto_chdir  = 1
let g:vimwiki_auto_header = 1
let g:vimwiki_ext2syntax = {}

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

">> Viewdoc
let g:viewdoc_open = 'topleft new'
let g:viewdoc_winwidth_max = 100

">> Undotree
let g:undotree_SplitWidth = 45
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_DiffCommand = "diff -dp -U 1"

">> Tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_width = 30

" tagbar languages in plugin/tagbar-types.vim

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
  \ '\c\v^__tagbar|^[doc\d*\]$|^diffpanel'

let g:airline#extensions#branch#format = 2

">> interestingwords
" These are jellybeans colors and some complements
let g:interestingWordsGUIColors = ['#C4A258','#6AADA0', '#71B9F8', '#A037B0', '#CF6A4C', '#D8AD4C']
let g:interestingWordsTermColors = ['179', '73', '75', '133', '167', '136']
" }}}

" {{{ Commands
" Preview markdown mail -- I edit with headers so I box them in a code block.
command! MailPreview     enew | set bt=nofile | 0r # | exe 'norm! 0O```<Esc>}O```' | silent exe '%!mutt-md2html | mutt-html2txt' | 0
command! MailPreviewHTML enew | set bt=nofile | setf html | 0r # | exe 'norm! 0O```<Esc>}O```' | silent exe '%!mutt-md2html' | 0
" }}}

" Local stuff, finish up
try
  execute 'source ' . s:filename . '.local'
catch
endtry

" {{{ Terminal tweaks
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
" }}}
