require("nvim-tree").setup()

vim.keymap.set('n', '<leader>tt', '<cmd>NvimTreeToggle<cr>', { desc = '[T]oggle [T]ree' })
