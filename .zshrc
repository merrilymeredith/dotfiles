# Version/environment management tools to load
envthings=(plenv rbenv ndenv)

# DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

typeset -U path

if [ -f ~/.zshrc.local-pre ]; then
  source ~/.zshrc.local-pre
fi

if [ -f ~/.zgen/zgen.zsh ]; then
  source ~/.zgen/zgen.zsh

  if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/common-aliases
    zgen oh-my-zsh plugins/gitfast

    zgen load zsh-users/zsh-syntax-highlighing
    zgen load ~/.oh-my-zsh.cust/themes/mhoward

    zgen save
  fi
fi

# User configuration
path=( "$HOME/bin" "$path[@]" )

source ~/.profile.common

for ENVTHING in $envthings; do
  if [ -d ~/.$ENVTHING ]; then
    path=( ~/.$ENVTHING/bin "$path[@]" )
    eval "$($ENVTHING init - zsh)"
  fi
done

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
