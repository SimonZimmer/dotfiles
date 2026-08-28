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
export GITHUB_PERSONAL_ACCESS_TOKEN="$(gh auth token 2>/dev/null)"

# Load secrets
[ -f ~/.secrets ] && source ~/.secrets

# opencode
export PATH=/Users/simonzimmermann/.opencode/bin:$PATH


# Added by Antigravity CLI installer
export PATH="/Users/simonzimmermann/.local/bin:$PATH"

# opencode
export PATH=/home/simonzimmermann/.opencode/bin:$PATH
eval "$(/bin/brew shellenv)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin  # add to .zshrc
export PATH="/home/simonzimmermann/.terragrunt/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# >>> oh-my-opencode-slim background subagents >>>
export OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS=true
export OPENCODE_ENABLE_EXA=1
# <<< oh-my-opencode-slim background subagents <<<
