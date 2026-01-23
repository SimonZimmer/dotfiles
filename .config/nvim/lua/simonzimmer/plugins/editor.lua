return {
  {
    'folke/trouble.nvim',
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document diagnostics" },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('todo-comments').setup()
    end,
  },

  {
    'stevearc/oil.nvim',
    cmd = { "Oil" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    config = function()
      require('oil').setup()
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>tr", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    },
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 35,
          side = 'left',
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
      })
      local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
      vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = normal_bg })
      vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { bg = normal_bg })
    end,
  },

  {
    'nvim-pack/nvim-spectre',
    cmd = { "Spectre" },
    keys = {
      { "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
    },
  },

  { 'github/copilot.vim', event = "VeryLazy" },
}
