# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mhoward"
ZSH_CUSTOM=~/.oh-my-zsh.cust

DISABLE_AUTO_UPDATE="true"
# DISABLE_UPDATE_PROMPT="true"

plugins=( common-aliases gitfast )
envthings=( plenv rbenv ndenv )

if [ -f ~/.zshrc.local-pre ]; then
  source ~/.zshrc.local-pre
fi

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

typeset -U path

source $ZSH/oh-my-zsh.sh

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
