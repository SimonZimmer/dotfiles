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

# BASIC
# defaults
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
export LD_LIBRARY_PATH="/Library/Developer/CommandLineTools/usr/lib/:$LD_LIBRARY_PATH"
export PATH="/usr/local/Cellar/llvm/13.0.1_1/bin/:$PATH"
export PATH="/usr/local//Cellar/llvm/14.0.6_1/bin/clangd:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export BAT_THEME="TwoDark"

dotfiles config status.showUntrackedFiles no
export PATH="/usr/local/opt/llvm/bin:$PATH"

export CMAKE_USER_MAKE_RULES_OVERRIDE=$HOME/.config/cmake_options.txt
