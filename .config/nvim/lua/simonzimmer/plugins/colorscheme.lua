return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      style = 'night',
      dim_inactive = true,
      sidebars = { "qf", "help", "terminal", "packer", "neogitstatus", "nvim-tree", "Trouble" },
      cache = true, -- Enable caching for better performance
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
          bg = c.bg,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg,
          fg = c.bg,
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
          bg = c.bg,
          fg = c.bg,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg,
          fg = c.bg,
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
        hl.SnacksNormal = {
          bg = c.bg,
          fg = c.fg_dark,
        }
        hl.SnacksNormalNC = {
          bg = c.bg,
          fg = c.fg_dark,
        }
        hl.SnacksWinBorder = {
          bg = c.bg,
          fg = c.border_highlight,
        }
        hl.FloatBorder = {
          bg = c.bg,
          fg = c.bg,
        }
      end,
    }
    vim.cmd.colorscheme("tokyonight")
  end
}