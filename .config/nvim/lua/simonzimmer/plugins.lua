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
    --'AlexvZyl/nordic.nvim',
    'navarasu/onedark.nvim',
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
    'APZelos/blamer.nvim',
    'nvim-pack/nvim-spectre',
    'rhysd/vim-clang-format',
    'nvim-pack/nvim-spectre',
    'rhysd/vim-clang-format',
    'rmagatti/goto-preview',
    'nvim-neotest/neotest',
    'nvim-neotest/neotest-python',
    'antoinemadec/FixCursorHold.nvim',
    'andythigpen/nvim-coverage',
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
    'jose-elias-alvarez/null-ls.nvim',
    -- debugging
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python',
})

require("coverage").setup()
require('gitsigns').setup()
require('mason').setup()
require('goto-preview').setup()
require('onedark').setup {
    style = 'dark'
}
require('onedark').load()

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

require("neotest").setup({
  adapters = {
    require("neotest-python")({
        runner = "pytest",
    })
  }
})
