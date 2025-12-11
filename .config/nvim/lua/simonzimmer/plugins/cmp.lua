return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-cmdline',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require'cmp'

    cmp.setup({
      window = {
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      },
      {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    local lspkind = require('lspkind')
    cmp.setup {
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol',
          maxwidth = 50,
          ellipsis_char = '...',
        })
      }
    }
  end,
}
