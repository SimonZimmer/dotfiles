# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git docker)
source $ZSH/oh-my-zsh.sh

# Powerlevel10k Configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Editor Configuration
export VISUAL=nvim
export EDITOR="$VISUAL"

# Environment Variables
export PATH="/usr/local/bin:$PATH"
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
alias kitdiff="git difftool --no-symlinks --dir-diff"
alias k='kubectl'
alias tf='terraform'
alias tg='terragrunt'

# Additional PATHs
export PATH="/usr/local/sbin:$PATH"
export PATH="/Library/Developer/CommandLineTools/usr/bin:$PATH"
export PATH="/Library/Developer/CommandLineTools/:$PATH"
export PATH="$PATH:/Users/simonzimmermann/.local/bin"
export PATH="$PATH:/Users/simonzimmermann/Library/Python/3.9/bin"
export PATH="$PATH:/opt/homebrew/bin/black"

# LLVM and Development Flags
#export PATH="/usr/local/opt/llvm@12/bin:$PATH"
#export LDFLAGS="-L/usr/local/opt/llvm@12/lib"
#export CPPFLAGS="-I/usr/local/opt/llvm@12/include"
#export PKG_CONFIG_PATH="/usr/local/opt/llvm@12/lib/pkgconfig"
#export BAT_THEME="TwoDark"

# SDK Configuration
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export CMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.5.sdk"

# Git Configuration
dotfiles config status.showUntrackedFiles no

#touch ~/.hushlogin


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

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/simonzimmermann/.rd/bin:$PATH"
alias python='/opt/homebrew/opt/python@3.13/libexec/bin/python3'
alias python3='/opt/homebrew/opt/python@3.13/libexec/bin/python3'
alias pip='/opt/homebrew/opt/python@3.13/libexec/bin/pip3'
alias pip3='/opt/homebrew/opt/python@3.13/libexec/bin/pip3'

export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin