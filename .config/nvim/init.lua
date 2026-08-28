-- Pre-load filetype detection to avoid issues with some plugins and Neovim versions
pcall(require, "vim.filetype.detect")

-- CapsLock → Escape (normal, visual, operator-pending)
vim.keymap.set({ 'n', 'v', 'o' }, '<CapsLock>', '<Esc>', {})

require("simonzimmer")
