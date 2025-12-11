return {
  'nvim-neotest/neotest',
  cmd = { "Neotest" },
  keys = {
    { "<leader>tn", "<cmd>lua require('neotest').run.run()<cr>", desc = "Run nearest test" },
    { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run file tests" },
    { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Toggle test summary" },
  },
  dependencies = {
    'nvim-neotest/neotest-python',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          runner = "pytest",
        })
      }
    })
  end,
}
