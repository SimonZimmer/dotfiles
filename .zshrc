# Powerlevel10k Configuration
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
source ~/.p10k.zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
plugins=(git docker)
source $ZSH/oh-my-zsh.sh

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

# Zsh Syntax Highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

touch ~/.hushlogin
