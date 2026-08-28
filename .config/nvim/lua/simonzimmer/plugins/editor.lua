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
    lazy = false,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    config = function()
      require('oil').setup()
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
