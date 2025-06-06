DISABLE_AUTO_UPDATE="true"
# DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
VI_MODE_SET_CURSOR="true"
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE="true"

if [ -f ~/.zshrc.local-pre ]; then
  source ~/.zshrc.local-pre
fi

if [ -f ~/.zgen/zgen.zsh ]; then
  source ~/.zgen/zgen.zsh

  if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/vi-mode
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load ~/.oh-my-zsh.cust/themes/mhoward
    zgen save
  fi
fi

KEYTIMEOUT=25
REPORTTIME=5
HISTORY_IGNORE="ls|cd|cd {-,..}|pwd|exit|date|privim*|cht.sh*"

setopt list_packed
setopt correct
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt interactive_comments

fpath=(~/.lib/zsh/ $fpath)

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

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

path[1,0]=(~/bin)
