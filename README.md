# dotfiles

My personal development configuration using [nvim](https://github.com/neovim/neovim), [kitty](https://github.com/kovidgoyal/kitty) and [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh/).

Also stores some configuration for `git` and `conan`.

![demo](https://github.com/SimonZimmer/dotfiles/blob/master/.config/demo.png)

# 📚 Requirements
* Neovim >= 0.9.0
* Zoxide
* Python
* [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
* [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraMono.zip)

# 📦 Installation
* Clone your repo onto the new machine as a bare repository into a temporary directory
```
 git clone \
   --separate-git-dir=$HOME/dotfiles \
   https://github.com/SimonZimmer/dotfiles \
   dotfiles-tmp
```

* Copy the snapshot from your temporary directory to the correct locations on your new machine.
```
rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
```

* Remove the temporary directory
```
rm -rf dotfiles-tmp
```

* Setup global environments for python
This is so you don't have to install the neovim and debugpy pip package in every virtual environment you are going to use
```
mkdir ~/.virtualenvs
cd ~/.virtualenvs
python3 -m venv neovim
source ./neovim/bin/activate
pip install neovim

mkdir ~/.virtualenvs
cd ~/.virtualenvs
python3 -m venv debugpy
source ./debugpy/bin/activate
pip install debugpy
```

# 🪴 Usage Notes
* For python-development, make sure you always activate your virtual environment before opening neovim
* For C / C++ development, make sure to always invoke the cmake generator with `-DCMAKE_EXPORT_COMPILE_COMMANDS=1`.
This is needed for `clangd` to do its work properly
