#!/usr/bin/env zsh

# #####
# this is just a tweaked nicoulaj.zsh-theme
# #####

# ------------------------------------------------------------------------------
# Prompt for the Zsh shell:
#   * One line.
#   * VCS info on the right prompt.
#   * Only shows the path on the left prompt by default.
#   * Crops the path to a defined length and only shows the path relative to
#     the current VCS repository root.
#   * Wears a different color wether the last command succeeded/failed.
#   * Shows user@hostname if connected through SSH.
#   * Shows if logged in as root or not.
# ------------------------------------------------------------------------------

## from omz lib/spectrum.zsh
# typeset -AH FX FG
# FX[reset]="%{[00m%}"
# FX[bold]="%{[01m%}"
# FX[no-bold]="%{[22m%}"
# FG[071]="%{[38;5;071m%}"
# FG[124]="%{[38;5;124m%}"
# FG[242]="%{[38;5;242m%}"

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_DEFAULT_END='❯'
PROMPT_ROOT_END='❯❯❯'
PROMPT_SUCCESS_COLOR=$FG[071]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]

if [[ ! "$(locale LC_CTYPE 2>/dev/null)" =~ 'UTF-8' || "$(print -P %l)" =~ '^[0-9v]' ]]
then
  PROMPT_DEFAULT_END='%%'
  PROMPT_ROOT_END='#'
fi

# Set required options.
setopt promptsubst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable git hg 
zstyle ':vcs_info:*:*' check-for-changes false # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b %u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%r/%s/%b %u%c"
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

# Define prompts.

MODE_INDICATOR='[N] '

PROMPT="%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} "
RPROMPT='$(vi_mode_prompt_info)'"%{$PROMPT_VCS_INFO_COLOR%}"'${vcs_info_msg_1_:- }'"%{$FX[reset]%}"
