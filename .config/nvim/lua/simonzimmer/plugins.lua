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
    'neovim/nvim-lspconfig',
    {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
        require("lsp-zero").setup()
        require('lspconfig').lua_ls.setup({})
    end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup({
              ensure_installed = {
                "clangd",
                "clang-format",
                "codelldb",
                "cmake-language-server",
                "flake8",
                "pyright",
                "black",
                "rust_analyzer",
                "sumneko_lua"
              }
            })
        end,
    },
    'jose-elias-alvarez/null-ls.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
    'jvgrootveld/telescope-zoxide',
    'nvim-lua/plenary.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require 'nvim-tree'.setup({
                hijack_cursor = true,
                sync_root_with_cwd = true,
                view = view,
                git = {
                    ignore = false
                },
                renderer = renderer,
                diagnostics = {
                    enable = true
                }
            })
        end
    },
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
    'folke/twilight.nvim',
    'APZelos/blamer.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
        'navarasu/onedark.nvim',
        config = function()
          require("onedark").setup({
              style = 'dark'
          })
          require("onedark").load()
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    'rhysd/vim-clang-format',
    {
        'nvim-pack/nvim-spectre',
        keys = {
            { "<leader>S", "<cmd>lua require('spectre').open()<CR>", desc = "Open Spectre" },
        },
    },
    'rhysd/vim-clang-format',
    {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup()
        end,
    },
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python',
    'nvim-neotest/neotest-python',
    {
    'nvim-neotest/neotest',
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    runner = "pytest",
                })
            }
        })
    end,
    },
    'antoinemadec/FixCursorHold.nvim',
    -- autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
    'github/copilot.vim',
    -- debugging
    'rhysd/vim-clang-format',
    {
        'simrat39/rust-tools.nvim',
        config = function()
            require('rust-tools').setup({
              server = {
                on_attach = function(_, bufnr)
                  vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                  vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
              },
            })
        end,
    },
})
