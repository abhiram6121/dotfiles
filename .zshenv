# ENVIRONMENT
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ZSH DOTDIR
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# PATH SETUP (Zsh-native tied array)
typeset -U path PATH
path=("$HOME/.local/bin" $path)

# DEFAULTS
export EDITOR='zeditor'
export VISUAL='zeditor'
export PAGER='less'

# LOCALE
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
