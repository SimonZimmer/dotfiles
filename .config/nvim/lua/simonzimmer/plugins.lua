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
vim.cmd('let $CFLAGS = "-Wno-nullability-completeness"')

require("lazy").setup(
{
    'VonHeikemen/lsp-zero.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        tag = 'v0.9.2',
        config = function()
            require'nvim-treesitter.configs'.setup {
              sync_install = false,
              auto_install = false,
              highlight = {
                enable = true,
                additional_vim_regex_highlighting = true,
              },
            }
        end
    },
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'dark'
            }
            require('onedark').load()
        end
    },    'folke/trouble.nvim',
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
    },
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "clangd", "pylsp" },
            }
        end,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            require('mason-tool-installer').setup {
                ensure_installed = {
                  'cmake-language-server',
                  'lua-language-server',
                },
                auto_update = true,
            }
        end,
    },
    'neovim/nvim-lspconfig',
    'onsails/lspkind.nvim',
    'nvim-tree/nvim-tree.lua',
    'folke/todo-comments.nvim',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    'APZelos/blamer.nvim',
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/neotest-python',
            'nvim-neotest/nvim-nio',
        },
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
    {
        'folke/which-key.nvim',
        tag = 'stable',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
            'echasnovski/mini.icons'
        },
        config = function()
          require("which-key").setup()
        end,
    },
    {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup()
        end,
    },
    {
        'numToStr/FTerm.nvim',
        config = function()
            require'FTerm'.setup({
                border = 'double',
                dimensions  = {
                    height = 0.9,
                    width = 0.9,
                },
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
    'nvim-pack/nvim-spectre',
    -- autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    -- debugging
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python',
    'github/copilot.vim'
})
