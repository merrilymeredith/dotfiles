set nocompatible

let on_windows=0
if has('win32') || has('win64') 
  " vim in cygwin has win32 = 0 and win32unix = 1
  let on_windows=1
end

" call pathogen#infect()
" call pathogen#helptags()

" Setting up Vundle - the vim plugin bundler
  let installed_vundle=0

  if on_windows == 0
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
  else
    let vundle_readme=expand('~/vimfiles/bundle/vundle/README.md')
  endif

  if !filereadable(vundle_readme)
    if !executable('git')
      echo "You probably want git installed and in PATH"
      quit
    endif

    let installed_vundle=1
    echo "Installing Vundle.."
    echo ""
    if on_windows == 0
      silent !mkdir -p ~/.vim/bundle
      silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    else
      "windows is weird about args and quoting
      silent execute '!mkdir "'. $HOME .'\vimfiles\bundle"'
      silent execute '!git clone https://github.com/gmarik/vundle "'. $HOME .'\vimfiles\bundle\vundle"'
    endif
  endif

  if on_windows == 0
    set rtp+=~/.vim/bundle/vundle/
  else
    set rtp+=~/vimfiles/bundle/vundle/
  endif

  call vundle#rc()
  Plugin 'gmarik/vundle'

  Plugin 'altercation/vim-colors-solarized'
  Plugin 'bling/vim-airline'

  Plugin 'Shougo/vimproc.vim'
  Plugin 'Shougo/unite.vim'
  Plugin 'Shougo/vimshell.vim'
  Plugin 'sjl/gundo.vim'
  Plugin 'majutsushi/tagbar'
  Plugin 'godlygeek/tabular'
  Plugin 'tomtom/tcomment_vim'

  Plugin 'danchoi/ri.vim'
  Plugin 'tpope/vim-fugitive'
  Plugin 'ludovicchabant/vim-lawrencium'

  if installed_vundle == 1
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
  endif
" Setting up Vundle - the vim plugin bundler end


syntax on
filetype plugin indent on

set enc=utf-8

set hlsearch
set ic smartcase

set lcs=tab:→·,trail:·

set ve=block

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
" vim: enc=utf-8 et sts=2 sw=2

set backspace=indent,eol,start

" set nu
set scrolloff=2
set ruler
set showcmd
set wildmenu

nmap <silent> <F1> :Unite buffer<CR>
nmap <silent> <F2> :Unite file<CR>
nmap <silent> <F3> :VimShell<CR>
map  <silent> <F4> :noh<CR>
nmap <silent> <F5> :GundoToggle<CR>
nmap <silent> <F8> :TagbarToggle<CR>

" This is supposed to get a CtrlP workalike with fuzzy match
" but i need to fix ignores and always chdir to a good place
if has("win32") || has("win16")
  nmap <silent> <S-F2> :Unite -start-insert file_rec:!<CR>
else
  nmap <silent> <S-F2> :Unite -start-insert file_rec/async:!<CR>
endif

" F-n keys call out to normal mode from insert mode
imap <F1> <C-O><F1>
imap <F2> <C-O><F2>
" imap <F3> <C-O><F3>
imap <F4> <C-O><F4>
" imap <F5> <C-O><F5>
" imap <F6> <C-O><F6>
" imap <F7> <C-O><F7>
imap <F8> <C-O><F8>

" Don't assume to scan includes when autocompleting
set cpt-=i

" Never open with folds collapsed
set nofoldenable

set lbr
set sbr=»\ 

set statusline=%f%m%r%h%w\ %y\ %=%l,%c\ %p%%\ %L
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

  set guifont=Consolas:h11
  set guioptions-=t
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

  set guifont=Droid\ Sans\ Mono\ Slashed\ 10
endif

set backupdir=$MYVIM/var/backup//,.
set directory=$MYVIM/var/tmp//,.

set backup
set autowrite
" set hidden  -- autowrite vs hidden, haven't decided.

if has('persistent_undo')
  set undofile
  set undodir=$MYVIM/var/undo//,.
end


autocmd FileType text setlocal textwidth=78


" -- Perl stuff
function! PerlSettings ()
  setlocal keywordprg=perldoc\ -f
  setlocal makeprg=perl\ -c\ %\ $*
  setlocal errorformat=%m\ at\ %f\ line\ %l
endfunction

autocmd FileType perl call PerlSettings()

" preload templates into new buffers by file extension
" autocmd BuffNewFile * silent! 0r $MYVIM/templates/%:e.template

" strip trailing whitespace on save
" autocmd BufWritePre * :%s/\s+$//e

"let perl_fold = 1           "perl fold scanning is slow
let perl_include_pod = 1

" -- Gundo
" I prefer python3 on windows if I have to use it.
if on_windows == 1
  let g:gundo_prefer_python3=1
endif

" -- Tagbar
if on_windows == 1
  let g:tagbar_ctags_bin = 'C:\Users\mhoward\bin\ctags.exe'
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


" -- Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
let g:unite_source_history_yank_enable = 1

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" -- Airline
let g:airline#extensions#whitespace#enabled = 0


" Local stuff
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

  set columns=120 lines=40

  colorscheme solarized
else
  if &t_Co == 256
    colorscheme jellybeans
  end
end


