vim.keymap.set('n', '<leader>rt', '<cmd>lua require("neotest").run.run()<CR>', { desc = '[r]un [t]est' })
vim.keymap.set('n', '<leader>rat', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { desc = '[r]un [a]ll [t]ests' })
