" vim: et sts=2 sw=2
" vim: fdm=marker

set nocompatible

let on_windows=0
if has('win32') || has('win64') 
  " vim in cygwin has win32 = 0 and win32unix = 1
  let on_windows=1
endif

" Set up Vundle and plugins  {{{
  let installed_vundle=0

  if on_windows == 0
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
  else
    let vundle_readme=expand('~/vimfiles/bundle/vundle/README.md')
  endif

  if !filereadable(vundle_readme)
    if !executable('git')
      echo "You probably want git installed and in PATH."
      if on_windows == 1
        echo " http://chocolatey.org "
      endif
      quit
    endif

    let installed_vundle=1
    if on_windows == 0
      echo "Installing Vundle..."
      echo ""
      silent !mkdir -p ~/.vim/bundle
      silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    else
      echo "Installing Vundle and Plugins..."
      " This happens in a series of minimized cmd windows rather than the cool
      " progress display we normally get.

      " Also windows is weird about args and quoting:
      silent execute '!mkdir "'. $HOME .'\vimfiles\bundle"'
      silent execute '!git clone https://github.com/gmarik/vundle "'. $HOME .'\vimfiles\bundle\vundle"'
    endif
  endif

  if on_windows == 0
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
  else
    set rtp+=~/vimfiles/bundle/vundle/
    call vundle#rc('~/vimfiles/bundle')
  endif

  Plugin 'gmarik/vundle'

  Plugin 'altercation/vim-colors-solarized'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'bling/vim-bufferline'
  Plugin 'vasconcelloslf/vim-interestingwords'

  Plugin 'editorconfig/editorconfig-vim'

  Plugin 'Shougo/vimproc.vim'
  Plugin 'Shougo/unite.vim'
  Plugin 'Shougo/vimfiler.vim'
  Plugin 'Shougo/unite-session'
  Plugin 'sjl/gundo.vim'
  Plugin 'majutsushi/tagbar'

  Plugin 'godlygeek/tabular'
  Plugin 'tomtom/tcomment_vim'
  Plugin 'tpope/vim-unimpaired'
  Plugin 'tpope/vim-endwise'

  Plugin 'vimwiki/vimwiki'

  Plugin 'Shougo/neocomplcache.vim'
  Plugin 'c9s/perlomni.vim'
  Plugin 'rking/ag.vim'

  Plugin 'tpope/vim-fugitive'
  Plugin 'ludovicchabant/vim-lawrencium'
  Plugin 'mhinz/vim-signify'

  Plugin 'asciidoc/vim-asciidoc'
  Plugin 'vim-perl/vim-perl'
  Plugin 'sheerun/vim-polyglot'
  Plugin 'yko/mojo.vim'
  Plugin 'slashmili/alchemist.vim'
  Plugin 'nathangrigg/vim-beancount'

  let g:no_viewdoc_maps = 1
  Plugin 'powerman/vim-plugin-viewdoc'
  Plugin 'powerman/vim-plugin-AnsiEsc'

  try
    if on_windows == 1
      source ~/_vimrc.local-pre
    else
      source ~/.vimrc.local-pre
    endif
  catch
  endtry

  if installed_vundle == 1
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
    if on_windows == 1
      " Windows build just isn't there with exec $0, so we already have some
      " odd errors and get a weird UI at the end.
      echo "Please restart vim to continue with plugins installed."
      quit
    endif
  endif
" }}}


" Key maps {{{

" F1 - Unite to switch buffers
nmap <silent> <F1> :Unite buffer<CR>
" S-F1 - Unite to switch windows or tabs
nmap <silent> <S-F1> :Unite -quick-match -short-source-names window tab:no-current<CR>
nmap <silent> <A-F1> :Unite session<CR>
nmap <silent> <F2> :VimFilerExplorer<CR>
map  <silent> <F4> :noh<CR>
nmap <silent> <F5> :GundoToggle<CR>
nmap <silent> <F8> :TagbarToggle<CR>

" This is supposed to get a CtrlP workalike with fuzzy match but i need to fix
" ignores and always chdir to a good place
if on_windows == 1
  nmap <silent> <S-F2> :Unite -start-insert file_rec:!<CR>
else
  nmap <silent> <S-F2> :Unite -start-insert file_rec/async:!<CR>
endif

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

" navigate by on-screen lines
map j gj
map k gk

" Select last paste
map gV `[v`]

" clear all interestingwords with \\k since \K is ri.vim
nnoremap <silent> <leader><leader>k :call UncolorAllWords()<CR>

nnoremap <silent> <leader>gt :SignifyToggle<CR>

" K: doc, gK: Doc w/o using syntax hints, gKK: doc current filename
nmap K   :call ViewDoc('doc', '<cword>')<CR>
nmap gK  :call ViewDoc('doc', expand('<cword>'))<CR>
nmap gKK :call ViewDoc('doc', expand('%'))<CR>

" Tabular shortcuts
map <leader>ta :Tabularize first_arrow<CR>
map <leader>te :Tabularize first_eq<CR>
map <leader>tc :Tabularize /:\zs<CR>
map <leader>tm :Tabularize methods<CR>

function! AutoFmtToggle()
  if &formatoptions =~ 'a'
    setl fo-=a
    echo '-a'
  else
    setl fo+=a
    echo '+a'
  endif
endfunction

map <silent> <leader>a :call AutoFmtToggle()<CR>

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
set showcmd
set wildmenu
set wildignorecase

set ttimeout
set ttimeoutlen=200

set tags+=.tags

" Ignore compiled files and repositories
set wildignore=*.o,*~,*.pyc
if on_windows == 1
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

if on_windows == 1
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

if on_windows == 1
  set guifont=DejaVu_Sans_Mono:h10:cDEFAULT
  set linespace=0
elseif has('osx')
  set guifont=DejaVu\ Sans\ Mono:h11
else
  set guifont=DejaVu\ Sans\ Mono\ 10
endif

set guioptions-=Tmt   "no toolbar, menu, tearoffs

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

  autocmd VimEnter * call AutoSessionConfig()

  autocmd FocusLost * silent! wa

  " preload templates into new buffers by file extension
  "autocmd BufNewFile * silent! 0r $MYVIM/templates/%:e.template

  " double-click to edit
  autocmd FileType vimfiler nmap <buffer> <2-LeftMouse> <Plug>(vimfiler_edit_file)

  " Set file marks by "category" on switch-away
  autocmd BufLeave *.css,*,less,*.scss normal! mC
  autocmd BufLeave *.html,*.ep,*.tt    normal! mH
  autocmd BufLeave *.js                normal! mJ
  autocmd BufLeave *.pl,*.pm           normal! mP

  " Jump to last known pos
  autocmd BufReadPost *
    \ if &filetype != 'mail' && line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup AutoMkdir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" https://mjj.io/2015/01/27/encrypting-files-with-gpg-and-vim/
augroup encrypted
  autocmd!
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup viminfo=
  autocmd BufReadPost *.gpg :%!gpg --decrypt 2> /dev/null
  autocmd BufWritePre *.gpg :%!gpg -se -a --default-recipient-self
  autocmd BufWritePost *.gpg u
augroup END
"}}}


" Perl type-specific settings  {{{

" let perl_fold = 1    " perl fold scanning is slow
let perl_include_pod = 1
let perl_sub_signatures = 1
let perl_sync_dist = 200

" }}}


" Plugin settings  {{{

">> Vimwiki
let g:vimwiki_list = [
      \ {'path': '~/vimwiki/', 'auto_tags': 1, 'auto_toc': 1},
      \ {'path': '~/Documents/SpiderOak Hive/vimwiki', 'auto_tags': 1, 'auto_toc': 1}
      \ ]
let g:vimwiki_use_mouse = 1

">> Viewdoc
let g:viewdoc_open = 'topleft new'
let g:viewdoc_perldoc_format = 'ansi'
let g:viewdoc_winwidth_max = 100

">> Gundo
" I prefer python3 on windows if I have to use it. Needs a dll in path.
if on_windows == 1
  let g:gundo_prefer_python3=1
endif


">> Tagbar
if on_windows == 1
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
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
" let g:unite_source_history_yank_enable = 1

call unite#custom#profile('default', 'context', {'winheight': 10})

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

">> vimfiler
let g:vimfiler_as_default_explorer = 1


">> Airline
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 0

"keep bufferline from writing into the command line
let g:bufferline_echo = 0

"cycle the bufferline with current buf in 2nd-to-last spot
let g:bufferline_rotate = 1
let g:bufferline_fixed_index = -2


">> Signify
let g:signify_disable_by_default = 1
let g:signify_vcs_list = [ 'git', 'hg' ]


">> interestingwords
" These are jellybeans colors and some complements
let g:interestingWordsGUIColors = ['#C4A258', '#D8AD4C', '#6AADA0', '#71B9F8', '#A037B0', '#CF6A4C']
let g:interestingWordsRandomiseColors = 1


">> neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Use neocomplcache.
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
if !exists(":DiffOrig")
  " Diff unsaved buffer
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
" }}}

" Local stuff, finish up
try
  if on_windows == 1
    source ~/_vimrc.local
  else
    source ~/.vimrc.local
  endif
catch
endtry

if g:airline_powerline_fonts == 0 && $LANG =~ 'UTF-8'
  let g:airline_left_sep  = '▒'
  let g:airline_right_sep = g:airline_left_sep
endif

if has('gui_running')
  set number
  set background=dark

  set guicursor+=a:blinkwait1000-blinkon1200-blinkoff250

  if on_windows == 1
    set columns=120 lines=40
  endif

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


