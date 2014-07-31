" vim: et sts=2 sw=2
" vim: fdm=marker

set nocompatible

let on_windows=0
if has('win32') || has('win64') 
  " vim in cygwin has win32 = 0 and win32unix = 1
  let on_windows=1
end


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
      echo " http://chocolatey.org "
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
  Plugin 'bling/vim-airline'

  Plugin 'Shougo/vimproc.vim'
  Plugin 'Shougo/unite.vim'
  Plugin 'Shougo/vimshell.vim'
  Plugin 'Shougo/vimfiler.vim'
  Plugin 'sjl/gundo.vim'
  Plugin 'majutsushi/tagbar'
  Plugin 'godlygeek/tabular'
  Plugin 'tomtom/tcomment_vim'
  Plugin 'tpope/vim-unimpaired'
  Plugin 'tpope/vim-endwise'

  Plugin 'Shougo/neocomplcache.vim'
  Plugin 'c9s/perlomni.vim'
  Plugin 'rking/ag.vim'

  Plugin 'tpope/vim-fugitive'
  Plugin 'ludovicchabant/vim-lawrencium'
  Plugin 'mhinz/vim-signify'

  Plugin 'danchoi/ri.vim'
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'vim-perl/vim-perl'


  if installed_vundle == 1
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
    if on_windows == 1
      " Windows build just isn't there with exec $0, so we already
      " have some odd errors and get a weird UI at the end.
      echo "Please restart vim to continue with plugins installed."
      quit
    endif
  endif
" }}}


" Key maps, mostly plugin stuff on F-keys  {{{
nmap <silent> <F1> :Unite buffer<CR>
nmap <silent> <F2> :VimFilerExplorer<CR>
nmap <silent> <F3> :VimShell<CR>
map  <silent> <F4> :noh<CR>
nmap <silent> <F5> :GundoToggle<CR>
nmap <silent> <F8> :TagbarToggle<CR>

" This is supposed to get a CtrlP workalike with fuzzy match
" but i need to fix ignores and always chdir to a good place
if on_windows == 1
  nmap <silent> <S-F2> :Unite -start-insert file_rec:!<CR>
else
  nmap <silent> <S-F2> :Unite -start-insert file_rec/async:!<CR>
endif

" F-n keys call out to normal mode from insert mode
" only :noh seems smart to do.
"imap <F1> <C-O><F1>
"imap <F2> <C-O><F2>
"imap <F3> <C-O><F3>
imap <F4> <C-O><F4>
"imap <F5> <C-O><F5>
"imap <F6> <C-O><F6>
"imap <F7> <C-O><F7>
"imap <F8> <C-O><F8>

" chdir to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <leader>pp :setlocal paste!<cr>

" faster window nav
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
"}}}


" General settings  {{{
syntax on
filetype plugin indent on

set enc=utf-8

set hlsearch
set ic smartcase

if has('gui_running') || $LANG =~ 'UTF-8'
  set lcs=tab:⇥·,trail:·
  " eol:↩   not as useful as trail i think
  set fillchars=fold:∷,vert:│
endif

set ve=block

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

set backspace=indent,eol,start

"set nu
set scrolloff=2
set ruler
set showcmd
set wildmenu

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
set cpt-=i

" Never open with folds collapsed
set nofoldenable

set lbr
set sbr=»\ 

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
  set lsp=0
else
  set guifont=DejaVu\ Sans\ Mono\ 10
endif

set guioptions-=T    "disable toolbar and menu
set guioptions-=m
set guioptions-=t    "disable tearoffs

set backupdir=$MYVIM/var/backup//,.
set directory=$MYVIM/var/tmp//,.

set backup
set autowrite

if has('persistent_undo')
  set undofile
  set undodir=$MYVIM/var/undo//,.
end
" }}}


" Autocmds  {{{
augroup vimrc
  autocmd!

  " you have to go out of your way to make this stick
  autocmd BufNewFile,BufRead * setlocal formatoptions-=ro

  autocmd FileType text setlocal textwidth=78
  autocmd FileType perl call PerlSettings()

  " preload templates into new buffers by file extension
  "autocmd BufNewFile * silent! 0r $MYVIM/templates/%:e.template

  " simple strip trailing whitespace on save
  "autocmd BufWritePre *.pl,*.rb,*.js,*.css,*.md :%s/\s+$//e

augroup END
"}}}


" Perl type-specific settings  {{{

function! PerlSettings ()
  compiler perl
  " even with g:perl_compiler_force_warnings = 0, perl -w is used and
  " that's just noisy with intentional no-warnings blocks out there

  setlocal makeprg=perl\ -c\ %\ $*
endfunction

" perl fold scanning is slow
"let perl_fold = 1           
let perl_include_pod = 1

" }}}


" Plugin settings  {{{
">> Gundo
" I prefer python3 on windows if I have to use it.
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

let g:tagbar_type_perl = {
    \ 'kinds' : [
        \ 'p:packages:1:0',
        \ 'e:extends',
        \ 'r:roles',
        \ 'c:constants:0:0',
        \ 'f:formats:0:0',
        \ 'a:attributes',
        \ 's:subroutines',
        \ 'l:labels',
    \ ],
    \ 'deffile' : '$MYVIM/ctags/perl.cnf'
\ }


">> Unite
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
" let g:unite_source_history_yank_enable = 1

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

">> vimfiler
let g:vimfiler_as_default_explorer = 1
autocmd FileType vimfiler nmap <buffer> <2-LeftMouse> <Plug>(vimfiler_edit_file)

">> Airline
let g:airline#extensions#whitespace#enabled = 0

">> Signify
let g:signify_disable_by_default = 1
let g:signify_vcs_list = [ 'git', 'hg' ]

let g:signify_mapping_next_hunk = '<leader>gj'
let g:signify_mapping_prev_hunk = '<leader>gk'
let g:signify_mapping_toggle = '<leader>gt'

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
"Enabling the below allows module completion from CPAN, jeez
" let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

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

if has('gui_running')
  set nu
  set bg=dark

  if on_windows == 1
    " generally have a tiling wm on linux
    set columns=120 lines=40
  end

  colorscheme solarized
else

  if $TERM =~ 'screen'
    if $TERM == 'screen-bce'
      "if i'm not screen-bce, i'm not sure i have a good .screenrc in place
      set t_Co=256
    endif

    set mouse=a
  endif

  if $TERM =~ 'rxvt-unicode'
    set ttymouse=urxvt
    set mouse=a
  endif

  if &t_Co == 256
    colorscheme jellybeans
  end

end


