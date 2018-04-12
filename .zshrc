typeset -U omz_plugins zsh_plugins envthings

# Version/environment management tools to load
envthings=(plenv rakudobrew)

DISABLE_AUTO_UPDATE="true"
# DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

omz_plugins=(
  plugins/common-aliases
  plugins/colored-man-pages
  plugins/vi-mode
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
    for plugin in $omz_plugins; do zgen oh-my-zsh $plugin; done

    for plugin in $zsh_plugins; do zgen load $plugin; done
    zgen save
  fi
fi

KEYTIMEOUT=1
REPORTTIME=5

setopt list_packed
setopt correct
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt interactive_comments

export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

bindkey '\eOA' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search

source ~/.profile.common

for envthing in $envthings; do
  if [ -d ~/.$envthing ]; then
    path[1,0]="$HOME/.$envthing/bin"
    eval "$($envthing init - zsh)"
  fi
done

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

