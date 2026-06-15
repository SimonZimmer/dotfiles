# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"

# Optimization: Skip slow compaudit check
ZSH_DISABLE_COMPFIX="true"

# Define plugins first so we can add them to fpath
if [[ -n "$NVIM" ]]; then
  plugins=(git)
else
  plugins=(git docker zsh-syntax-highlighting)
fi

# Load Oh My Zsh (it will handle compinit)
source $ZSH/oh-my-zsh.sh

# Editor Configuration
export VISUAL=nvim
export EDITOR="$VISUAL"

# Environment Variables
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"
export DEFAULT_USER="$(whoami)"

# Terminal and Coloring
autoload -U colors && colors
export TERM="xterm-256color"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7f7f7f"

# Aliases
alias vim="nvim"
alias l='exa -lbF --git'
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias k='kubectl'
alias tf='terraform'
alias tg='terragrunt'
alias cat='bat'

# Cached SDKROOT to avoid xcrun overhead
export SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
export CMAKE_OSX_SYSROOT="$SDKROOT"

# Git Configuration - skip in Neovim for speed
if [[ -z "$NVIM" ]]; then
  dotfiles config status.showUntrackedFiles no 2>/dev/null
fi

# Function to switch between kubeconfigs
kuse() {
  local CONFIG_PATH="$HOME/.kube/configs/$1.yaml"
  if [ ! -f "$CONFIG_PATH" ]; then
    echo "❌ Kubeconfig '$1' not found at $CONFIG_PATH"
    return 1
  fi
  export KUBECONFIG="$CONFIG_PATH"
  export K9S_KUBECONFIG="$CONFIG_PATH"
  echo "✅ Switched to kubeconfig: $CONFIG_PATH"
  kubectl config get-contexts
}

# Fix for Neovim terminal input issues
if [[ -n "$NVIM" ]]; then
  export KEYTIMEOUT=20
  export ZSH_AUTOSUGGEST_STRATEGY=none
  unset ZSH_AUTOSUGGEST_USE_ASYNC
fi

# Static Starship initialization
if [[ ! -f ~/.starship_init.zsh ]]; then
  starship init zsh --print-full-init > ~/.starship_init.zsh
fi
source ~/.starship_init.zsh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/simonzimmermann/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH=/Users/simonzimmermann/.opencode/bin:$PATH


# Added by Antigravity CLI installer
export PATH="/Users/simonzimmermann/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/tfenv/bin:$PATH"
