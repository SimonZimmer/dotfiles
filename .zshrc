# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
if [[ -n "$NVIM" ]]; then plugins=(git docker); else plugins=(git docker zsh-syntax-highlighting); fi
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
unset zle_bracketed_paste

# Powerlevel10k Configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# Additional PATHs
export PATH="$PATH:/Library/Developer/CommandLineTools/usr/bin"
export PATH="$PATH:/Library/Developer/CommandLineTools/"
export PATH="$PATH:/Users/simonzimmermann/.local/bin"
export PATH="$PATH:/Users/simonzimmermann/Library/Python/3.14/bin"
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

export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin
# Reduce key timeout to prevent character swallowing
KEYTIMEOUT=1
alias cat='bat'

unalias kitdiff 2>/dev/nullkitdiff() {
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

# Fix Powerlevel10k rendering in Neovim (remove ambiguous icons)
if [[ -n "$NVIM" ]]; then
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_CONTENT_EXPANSION='>'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_CONTENT_EXPANSION='>'
  typeset -g POWERLEVEL9K_VCS_GIT_ICON=''
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=''
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON=''
  typeset -g POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON=''
  typeset -g POWERLEVEL9K_VCS_TAG_ICON=''
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON='+'
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='<'
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='>'
  typeset -g POWERLEVEL9K_DIR_ICON=''
  typeset -g POWERLEVEL9K_STATUS_OK_ICON=''
  typeset -g POWERLEVEL9K_STATUS_ERROR_ICON='x'
  typeset -g POWERLEVEL9K_EXECUTION_TIME_ICON=''
fi
