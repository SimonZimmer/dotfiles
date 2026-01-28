return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      style = 'night',
      sidebars = { "qf", "help", "terminal", "packer", "neogitstatus", "nvim-tree", "Trouble" },
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.NvimTreeNormal = {
          bg = c.bg_dark,
        }
        hl.NvimTreeNormalNC = {
          bg = c.bg_dark,
        }
        hl.NvimTreeWinSeparator = {
          fg = c.bg_statusline,
          bg = c.bg_statusline,
        }
      end,
    }
    vim.cmd.colorscheme("tokyonight")
  end
}