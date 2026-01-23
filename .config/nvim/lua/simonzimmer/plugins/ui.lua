return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'onedark',
          component_separators = '',
          section_separators = '',
          globalstatus = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff'},
          lualine_c = {'filename'},
          lualine_x = {'diagnostics', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      }
    end,
  },

  {
    'folke/which-key.nvim',
    tag = 'stable',
    event = "VeryLazy",
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      'echasnovski/mini.icons'
    },
    config = function()
      local wk = require("which-key")
      wk.setup()
      wk.add({
        { "-", "<cmd>Oil<cr>", desc = "Oil" },
        { "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", desc = "Spectre Toggle" },
        { "<leader>b", "<cmd>BlamerToggle<cr>", desc = "Blamer Toggle" },
        { "<leader>cp", "<cmd>Copilot panel<cr>", desc = "Copilot Panel" },
        { "<leader>todo", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
        { "<leader>gb", "<cmd>BlamerToggle<cr>", desc = "Git Blame" },
        { "<leader>h", group = "Helm" },
        { "<leader>hl", "<cmd>HelmLint<cr>", desc = "Helm Lint" },
        { "<leader>hh", "<cmd>HelmTemplate<cr>", desc = "Helm Template" },
        { "<leader>hv", "<cmd>!helm template . | less<cr>", desc = "Helm Preview" },
        { "<leader>k", group = "Kubernetes" },
        { "<leader>kb", "<cmd>KustomizeBuild<cr>", desc = "Kustomize Build" },
        { "<leader>kd", "<cmd>K8sDryRun<cr>", desc = "K8s Dry Run" },
        { "<leader>kv", "<cmd>!kustomize build --load-restrictor=LoadRestrictionsNone %:p:h | less<cr>", desc = "Kustomize Preview" },
        { "<leader>rat", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run All Tests in File" },
        { "<leader>rr", "<cmd>lua require('neotest').run.run()<cr>", desc = "Run Test" },
        { "<leader>x", group = "Diagnostics" },
      }, { mode = "n" })
    end,
  },

  { 'nvim-tree/nvim-web-devicons', lazy = true },
}
