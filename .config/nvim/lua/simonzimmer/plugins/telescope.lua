return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  cmd = "Telescope",
  keys = {
    { "<leader>ff", function() require('telescope.builtin').find_files() end, desc = "Find files" },
    { "<leader>fg", function() require('telescope.builtin').live_grep() end, desc = "Live grep" },
    { "<leader>fb", function() require('telescope.builtin').buffers() end, desc = "Buffers" },
    { "<leader>fh", function() require('telescope.builtin').help_tags() end, desc = "Help tags" },
    { "<leader>fd", function() require('telescope.builtin').diagnostics() end, desc = "Find diagnostics" },
    { "<leader>fk", function() require('telescope.builtin').keymaps() end, desc = "Find keymaps" },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local border_chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
    require('telescope').setup({
      defaults = {
        sort_mru = true,
        sorting_strategy = 'ascending',
        layout_config = {
          prompt_position = 'top'
        },
        borderchars = {
          prompt = border_chars,
          results = border_chars,
          preview = border_chars
        },
        border = true,
        multi_icon = '',
        entry_prefix = '   ',
        prompt_prefix = '   ',
        selection_caret = ' ▶ ',
        hl_result_eol = true,
        results_title = "",
        wrap_results = true,
      }
    })
  end,
}
