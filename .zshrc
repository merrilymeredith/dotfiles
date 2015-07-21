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

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"



source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
# export MANPATH="/usr/local/man:$MANPATH"

# export LANG=en_US.UTF-8

source ~/.profile.common

typeset -U path

for ENVTHING in $envthings; do
  if [ -d ~/.$ENVTHING ]; then
    path=( ~/.$ENVTHING/bin "$path[@]" )
    eval "$($ENVTHING init - zsh)"
  fi
done

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

