# Set the directory for zinit and its plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Download Zinit if it doesn't exist
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load plugins with Zinit
zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions

# fzf-tab for interactive completions
zinit light Aloxaf/fzf-tab

# Oh My Zsh plugins
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Initialize oh-my-posh for a custom prompt
if command -v oh-my-posh >/dev/null; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi

# Use GNU dircolors if available
if [[ -z "$LS_COLORS" ]] && command -v gdircolors >/dev/null; then
  eval "$(gdircolors -b)"
elif [[ -z "$LS_COLORS" ]] && command -v dircolors >/dev/null; then
  eval "$(dircolors -b)"
fi

# Volta
if [[ -d "$HOME/.volta" ]]; then
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
  export VOLTA_FEATURE_PNPM=1 # Enable pnpm support
fi

# Aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias vim='nvim'
alias c='clear'

# Keybindings
bindkey -e # Use Emacs-style keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;5C' forward-word # Ctrl+Right
bindkey '^[[1;5D' backward-word # Ctrl+Left

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt inc_append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Preview for fzf-tab when completing 'cd'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'

# fzf (Fuzzy Finder)
if command -v fzf >/dev/null; then
  eval "$(fzf --zsh)"
fi

# zoxide (Smarter 'cd' command)
if command -v zoxide >/dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi
