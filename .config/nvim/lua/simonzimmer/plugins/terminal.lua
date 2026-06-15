return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    image = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      ui_select = true,
    },
    bigfile = { enabled = true },
    dashboard = { 
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "s", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "S", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    explorer = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      terminal = {
        border = "rounded",
        width = 0.8,
        height = 0.8,
        wo = {
          winhighlight = "Normal:SnacksNormal,NormalNC:SnacksNormalNC,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC,FloatBorder:SnacksWinBorder,FloatTitle:SnacksWinBorder",
        },
      },
    },
  },
  keys = {
    { 
      "<leader>tt", 
      function() 
        Snacks.terminal.toggle(nil, { 
          env = { 
            NVIM_TERMINAL = "1",
            TERM = "xterm-256color",
          } 
        }) 
      end, 
      desc = "Toggle Terminal", 
      mode = { "n", "t" },
    },
    { 
      "<C-/>", 
      function() 
        Snacks.terminal.toggle(nil, { 
          env = { 
            NVIM_TERMINAL = "1",
            TERM = "xterm-256color",
          } 
        }) 
      end, 
      desc = "Toggle Terminal", 
      mode = { "n", "t" } 
    },
    { 
      "<C-_>", 
      function() 
        Snacks.terminal.toggle(nil, { 
          env = { 
            NVIM_TERMINAL = "1",
            TERM = "xterm-256color",
          } 
        }) 
      end, 
      desc = "Toggle Terminal", 
      mode = { "n", "t" } 
    },
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
