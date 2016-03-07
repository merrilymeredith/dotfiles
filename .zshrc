# Version/environment management tools to load
envthings=(plenv rbenv ndenv rakudobrew)

DISABLE_AUTO_UPDATE="true"
# DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

typeset -U path omz_plugins zsh_plugins

omz_plugins=(
  plugins/common-aliases
  plugins/gitfast
  plugins/colored-man-pages
)

zsh_plugins=(
  zsh-users/zsh-syntax-highlighting
  ~/.oh-my-zsh.cust/themes/mhoward
)

if [ -f ~/.zshrc.local-pre ]; then
  source ~/.zshrc.local-pre
fi

if [ -f ~/.zgen/zgen.zsh ]; then
  source ~/.zgen/zgen.zsh

  if ! zgen saved; then
    zgen oh-my-zsh
    for plugin in $omz_plugins[@]; do zgen oh-my-zsh $plugin; done

    for plugin in $zsh_plugins[@]; do zgen load $plugin; done
    zgen save
  fi
fi

# User configuration
path=("$HOME/bin" "$path[@]")

REPORTTIME=5

setopt list_packed
setopt correct
setopt hist_reduce_blanks
setopt hist_save_no_dups

export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

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
