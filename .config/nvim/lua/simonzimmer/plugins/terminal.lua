return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    terminal = {
      enabled = true,
      win = {
        style = "float",
        border = "rounded",
        wo = {
          winbar = "",
          statuscolumn = "",
          signcolumn = "no",
        },
      },
    },
  },
  keys = {
    { "<leader>tt", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal", mode = { "n", "t" } },
  },
  init = function()
    vim.api.nvim_create_user_command('KustomizeBuild',
      function()
        vim.cmd('split | term kustomize build --load-restrictor=LoadRestrictionsNone %:p:h')
      end,
      {}
    )

    vim.api.nvim_create_user_command('HelmTemplate',
      function()
        vim.cmd('split | term helm template . --debug')
      end,
      {}
    )

    vim.api.nvim_create_user_command('HelmLint',
      function()
        vim.cmd('split | term helm lint .')
      end,
      {}
    )

    vim.api.nvim_create_user_command('K8sDryRun',
      function()
        vim.cmd('split | term kubectl apply --dry-run=client -f %')
      end,
      {}
    )
  end,
}
