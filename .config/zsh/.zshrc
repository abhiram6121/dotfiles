# ZSH CONFIGURATION
# Author: abhiram <abhiram6121@gmail.com>
# SPDX-License-Identifier: MIT

# ENVIRONMENT & HISTORY
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_GLOB
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# COMPLETION SETTINGS
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'

# COMPLETION ENGINE
compdumpfile="$XDG_CACHE_HOME/zsh/zcompdump"
autoload -Uz compinit

if [[ -n "$compdumpfile"(#qN.mh+24) ]]; then
    compinit -u -d "$compdumpfile"
else
    compinit -u -C -d "$compdumpfile"
fi

# PLUGIN MANAGEMENT (ANTIDOTE)
zsh_plugins="$ZDOTDIR/.zsh_plugins"
fpath=(/usr/share/zsh-antidote/functions $fpath)
autoload -Uz antidote

if [[ ! -f ${zsh_plugins}.zsh || ${zsh_plugins}.txt -nt ${zsh_plugins}.zsh ]]; then
    antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi
source ${zsh_plugins}.zsh

# TOOLS & ALIASES
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

alias hx='helix'
alias n='nvim'
alias c='clear'
alias zed='zeditor'
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lvh'

# KEYBINDINGS
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# PROMPT
eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/ohmyposh/zen.toml)"
