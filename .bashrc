# .bashrc: executed for non-login shells
#          probably sourced by .bash_profile though

if [ -f ~/.bashrc.dist ]; then
  source ~/.bashrc.dist
fi

source ~/.bashrc.lib

path-prepend "$HOME/bin"

if path-prepend "$HOME/.plenv/bin"; then
  eval "$(plenv init -)"
fi

if path-prepend "$HOME/.rbenv/bin"; then
  eval "$(rbenv init -)"
fi


if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

source ~/.profile.common

