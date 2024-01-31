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
    'L3MON4D3/LuaSnip',
    'VonHeikemen/lsp-zero.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'dark'
            }
            require('onedark').load()
        end,
    },
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
    'jvgrootveld/telescope-zoxide',
    'nvim-lua/plenary.nvim',
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require("mason-lspconfig").setup{
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "clangd",
                    "pyright",
                    "pylsp",
                },
            }
        end,
    },
    {
        'w0rp/ale',
        config = function()
            vim.g.ale_fix_on_save = 1
            vim.g.ale_linters = {
                python = {'flake8', 'black'},
                c = {'clang', 'clangtidy'},
                cpp = {'clang', 'clangtidy'},
                bash = {'shellcheck'},
            }
            vim.g.ale_fixers = {
                python = {'black'},
                c = {'clang-format', 'clangtidy'},
                cpp = {'clang-format', 'clangtidy'},
                bash = {'shfmt'},
            }
            vim.g.ale_sign_error = '✗'
            vim.g.ale_sign_warning = '⚠'
            vim.g.ale_sign_info = 'ℹ'
            vim.g.ale_sign_style_error = '✗'
            vim.g.ale_sign_style_warning = '⚠'
            vim.g.ale_sign_style_info = 'ℹ'
            vim.g.ale_echo_msg_error_str = '✗'
            vim.g.ale_echo_msg_warning_str = '⚠'
            vim.g.ale_echo_msg_info_str = 'ℹ'
            vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
            vim.g.ale_lint_on_insert_leave = 1
            vim.g.ale_lint_on_insert = 0
            vim.g.ale_lint_on_text_changed = 'never'
            vim.g.ale_lint_on_enter = 0
            vim.g.ale_lint_on_filetype_changed = 0
            vim.g.ale_lint_on_save = 0
            vim.g.ale_lint_on_cursor_hold = 0
            vim.g.ale_lint_on_cursor_moved = 0
            vim.g.ale_lint_on_insert = 0
        end
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            require('mason-tool-installer').setup {
                ensure_installed = {
                  'cmake-language-server',
                  'lua-language-server',
                  'bash-language-server',
                },
                auto_update = true,
            }
        end,
    },
    'neovim/nvim-lspconfig',
    'onsails/lspkind.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    'folke/todo-comments.nvim',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    'APZelos/blamer.nvim',
    'nvim-treesitter/nvim-treesitter',
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
    {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup()
        end,
    },
    -- autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'github/copilot.vim',
    -- debugging
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python',
})

