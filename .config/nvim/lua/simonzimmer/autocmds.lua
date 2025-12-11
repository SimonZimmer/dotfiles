vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {"*.yml", "*.yaml"},
  callback = function()
    vim.bo.filetype = "yaml.azure-pipelines"
  end,
})
