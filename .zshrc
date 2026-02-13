# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"

# Conditional plugins based on environment
if [[ -n "$NVIM_TERMINAL" ]] || [[ -n "$NVIM" ]]; then
  plugins=(git docker)
else
  plugins=(git docker zsh-syntax-highlighting)
fi

source $ZSH/oh-my-zsh.sh

# Editor Configuration
export VISUAL=nvim
export EDITOR="$VISUAL"

# Environment Variables
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export CPLUS_INCLUDE_PATH="/usr/local/include"
export LIBRARY_PATH="/usr/local/lib"
export DEFAULT_USER="$(whoami)"

# Terminal and Coloring
autoload -U colors && colors
export TERM="xterm-256color"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7f7f7f"

# Aliases
alias vim="nvim"
alias git_rinse="git clean -xfd || true && \
                 git submodule foreach --recursive git clean -xfd || true && \
                 git reset --hard || true && \
                 git submodule foreach --recursive git reset --hard || true && \
                 git submodule update --init --recursive || true"
alias l='exa -lbF --git'
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias k='kubectl'
alias tf='terraform'
alias tg='terragrunt'
alias cat='bat'

# Additional PATHs
export PATH="$PATH:/Library/Developer/CommandLineTools/usr/bin"
export PATH="$PATH:/Library/Developer/CommandLineTools/"
export PATH="$PATH:/Users/simonzimmermann/.local/bin"
export PATH="$PATH:/Users/simonzimmermann/Library/Python/3.14/bin"
export PATH="$PATH:/opt/homebrew/bin/black"

# SDK Configuration
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export CMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.5.sdk"

# Git Configuration
dotfiles config status.showUntrackedFiles no

# kuse - A function to switch between kubeconfigs
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

# Autocompletion function
_kuse_completions() {
  local cur_word
  cur_word="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$(basename -s .yaml ~/.kube/configs/*.yaml 2>/dev/null)" -- "$cur_word")
 )
}

export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin

# Reduce key timeout to prevent character swallowing
KEYTIMEOUT=1

unalias kitdiff 2>/dev/null

kitdiff() {
    if [[ $# -eq 2 ]] && [[ -e "$1" ]] && [[ -e "$2" ]]; then
        kitty +kitten diff "$1" "$2"
    else
        git difftool --no-symlinks --dir-diff "$@"
    fi
}

# Fix for Neovim terminal input issues
if [[ -n "$NVIM" ]]; then
  export KEYTIMEOUT=20
fi

# Disable Zsh Autosuggestions in Neovim to fix cursor jumping/swallowing
if [[ -n "$NVIM" ]]; then
  export ZSH_AUTOSUGGEST_STRATEGY=none
  unset ZSH_AUTOSUGGEST_USE_ASYNC
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/simonzimmermann/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
alias nerdctl="nerdctl --address ~/.rd/run/containerd.sock"
eval "$(starship init zsh)"
