local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup(
{
    'nvim-treesitter/nvim-treesitter',
    'AlexvZyl/nordic.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
    'jvgrootveld/telescope-zoxide',
    'nvim-lua/plenary.nvim',
    'VonHeikemen/lsp-zero.nvim',
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
    'folke/twilight.nvim',
    'lewis6991/gitsigns.nvim',
    'Pocco81/auto-save.nvim',
    'APZelos/blamer.nvim',
    -- autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
    'github/copilot.vim',
    'simrat39/rust-tools.nvim',
    -- debugging
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python',
})

require('gitsigns').setup()
require('mason').setup()
require('auto-save').setup()

require('nordic').setup {
    theme='onedark',
    onedark = {
        brighter_whites = true,
    },
    bright_border = false,
    telescope = {
        style = 'flat',
    },
    nordic = {
        reduced_blue = true,
    },
    bold_keywords = false,
    italic_comments = true,
    transparent_bg = false,
    cursorline = {
        theme = 'flat',
        bold = false,
    },
    noice = {
        style = 'classic',
    },
}

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- Load the scheme.
vim.cmd.colorscheme 'nordic'
