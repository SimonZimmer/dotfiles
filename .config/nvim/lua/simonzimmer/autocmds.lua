vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {"azure-pipelines.yml", "azure-pipelines.yaml"},
  callback = function()
    vim.bo.filetype = "yaml.azure-pipelines"
  end,
})

-- Automatically check for file changes when focusing nvim or switching buffers
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "BufEnter" }, {
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- Notification when a file changes
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

-- Fix yanking in terminal mode (visual selection) and align styling
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.winhighlight = "Normal:NormalFloat"
    vim.keymap.set("v", "y", '"+y', { buffer = true, desc = "Yank to clipboard" })
  end,
})
