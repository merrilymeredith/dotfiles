# .bashrc: executed for non-login shells
#          probably sourced by .bash_profile though

if [ -f ~/.bashrc.dist ]; then
  source ~/.bashrc.dist
fi

source ~/.lib/bash/path.sh

for DIR in bin .cargo/bin .local/bin go/bin; do
  path-prepend "$HOME/$DIR"
done

if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

source ~/.profile.common

