# .bashrc: executed for non-login shells
#          probably sourced by .bash_profile though

if [ -f ~/.bashrc.dist ]; then
  source ~/.bashrc.dist
fi

HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:cd:cd -:cd ..:pwd:exit:date:privim:cht.sh"
HISTSIZE=5000

source ~/.lib/sh/path.bash

for DIR in bin .cargo/bin .local/bin go/bin .lib/stubs; do
  path-prepend "$HOME/$DIR"
done

if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

source ~/.profile.common

