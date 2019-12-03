typeset -U omz_plugins zsh_plugins envthings

# Version/environment management tools to load
envthings=(plenv rakudobrew)

DISABLE_AUTO_UPDATE="true"
# DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

omz_plugins=(
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
HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

setopt list_packed
setopt correct
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt interactive_comments

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Altered from what's shown on Arch wiki
[[ -n "${terminfo[khome]}" ]] && bindkey -- "${terminfo[khome]}" beginning-of-line
[[ -n "${terminfo[kend]}"  ]] && bindkey -- "${terminfo[kend]}"  end-of-line
[[ -n "${terminfo[kich1]}" ]] && bindkey -- "${terminfo[kich1]}" overwrite-mode
[[ -n "${terminfo[kbs]}"   ]] && bindkey -- "${terminfo[kbs]}"   backward-delete-char
[[ -n "${terminfo[kdch1]}" ]] && bindkey -- "${terminfo[kdch1]}" delete-char
[[ -n "${terminfo[kcuu1]}" ]] && bindkey -- "${terminfo[kcuu1]}" up-line-or-beginning-search
[[ -n "${terminfo[kcud1]}" ]] && bindkey -- "${terminfo[kcud1]}" down-line-or-beginning-search
[[ -n "${terminfo[kcub1]}" ]] && bindkey -- "${terminfo[kcub1]}" backward-char
[[ -n "${terminfo[kcuf1]}" ]] && bindkey -- "${terminfo[kcuf1]}" forward-char
[[ -n "${terminfo[kpp]}"   ]] && bindkey -- "${terminfo[kpp]}"   beginning-of-buffer-or-history
[[ -n "${terminfo[knp]}"   ]] && bindkey -- "${terminfo[knp]}"   end-of-buffer-or-history
[[ -n "${terminfo[kcbt]}"  ]] && bindkey -- "${terminfo[kcbt]}"  reverse-menu-complete

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

