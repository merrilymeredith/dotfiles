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

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

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

