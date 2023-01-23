vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
    local is_bootstrap = false
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        is_bootstrap = true
        vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    end

    use 'wbthomason/packer.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'jiangmiao/auto-pairs'
    use 'navarasu/onedark.nvim'
    require('onedark').load()

    use {
        {'nvim-telescope/telescope.nvim'},
        {'jvgrootveld/telescope-zoxide'},
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('telescope.builtin').setup()
        end
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
            require("luasnip.loaders.from_vscode").lazy_load()
        }
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {('nvim-tree/nvim-web-devicons')},
        config = function()
            require("nvim-tree").setup()
        end
    }

    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup()
      end
    }

    use {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup()
      end
    }

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" },
    })

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }

    if is_bootstrap then
        require('packer').sync()
    end

end)

