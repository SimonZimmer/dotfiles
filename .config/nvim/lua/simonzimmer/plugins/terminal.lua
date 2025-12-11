return {
  'akinsho/toggleterm.nvim',
  version = "*",
  keys = { "<c-\\>" },
  cmd = { "ToggleTerm" },
  config = function()
    require("toggleterm").setup{
      size = 20,
      open_mapping = [[<c-\>]],
      direction = 'horizontal',
      close_on_exit = true,
    }

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
