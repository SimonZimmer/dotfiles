vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {"azure-pipelines.yml", "azure-pipelines.yaml"},
  callback = function()
    vim.bo.filetype = "yaml.azure-pipelines"
  end,
})
