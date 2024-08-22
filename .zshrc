# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
source ~/.p10k.zsh
# OH MY ZSH
ZSH_THEME="powerlevel10k/powerlevel10k"

export PATH=/usr/local/bin:$PATH

export ZSH=/Users/simonzimmermann/.oh-my-zsh
# plugins
plugins=(git zsh-syntax-highlighting docker)
source $ZSH/oh-my-zsh.sh

#zoxide 
eval "$(zoxide init zsh)"

# BASIC defaults export VISUAL=nvim
export VISUAL=nvim
export EDITOR="$VISUAL"
export CPLUS_INCLUDE_PATH=/usr/local/include
export LIBRARY_PATH=/usr/local/lib
export DEFAULT_USER="$(whoami)"
# coloring
autoload -U colors && colors
export TERM="xterm-256color"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7f7f7f"

#ALIASES
alias vim="nvim"
alias git_rinse="git clean -xfd
             git submodule foreach --recursive git clean -xfd
             git reset --hard
             git submodule foreach --recursive git reset --hard
             git submodule update --init --recursive"
alias l='exa -lbF --git'
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias kitdiff="git difftool --no-symlinks --dir-diff"
alias cd="z"

#PATH
export PATH="~/.cargo/bin/:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/llvm@12/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm@12/lib"
export CPPFLAGS="-I/usr/local/opt/llvm@12/include"
export PKG_CONFIG_PATH="/usr/local/opt/llvm@12/lib/pkgconfig"
export BAT_THEME="TwoDark"
export PATH="/Library/Developer/CommandLineTools/usr/bin:$PATH"


dotfiles config status.showUntrackedFiles no
export PATH="/usr/local/opt/llvm/bin:$PATH"
export DEVPI_URL="http://localhost:8080/root/pypi/+simple/"
export PATH="/usr/local/opt/curl/bin:$PATH"
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export CMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.5.sdk"



# DEVPI
launchctl load /Library/LaunchDaemons/net.devpi.plist
launchctl start net.devpi 

# Created by `pipx` on 2024-06-13 10:39:22
export PATH="$PATH:/Users/simonzimmermann/.local/bin"
