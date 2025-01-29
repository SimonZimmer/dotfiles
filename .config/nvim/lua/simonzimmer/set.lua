vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.clipboard = 'unnamedplus'

vim.g.noswapfile = true

vim.opt.laststatus = 0

vim.api.nvim_set_keymap('x', 'p', 'pgvy', { noremap = true, silent = true })

pcall(vim.api.nvim_del_keymap, "i", "<Space>h")
