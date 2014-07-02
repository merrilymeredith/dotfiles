# .bashrc: executed for non-login shells
#          probably sourced by .bash_profile though

if [ -f ~/.bashrc.dist ]; then
  source ~/.bashrc.dist
fi

export EDITOR=vim
export PERL_CPANM_OPT='-n --prompt --reinstall'

if [ -d ~/bin ]; then
  export PATH="$HOME/bin:$PATH"
fi

if [ -d ~/.plenv ]; then
  export PATH="$HOME/.plenv/bin:$PATH"
  eval "$(plenv init -)"
fi

if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi


if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

