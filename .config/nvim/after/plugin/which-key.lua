local wk = require("which-key")

wk.add({
    { "-", "<cmd>Oil<cr>", desc = "Oil" },
    { "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", desc = "Spectre Toggle" },
    { "<leader>b", "<cmd>BlamerToggle<cr>", desc = "Blamer Toggle" },
    { "<leader>cp", "<cmd>Copilot panel<cr>", desc = "Copilot Panel" },
    { "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc = "Diagnostics" },
    { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Live Grep" },
    { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "Help Tags" },
    { "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", desc = "Keymaps" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
    { "<leader>fz", "<cmd>lua require('telescope').extensions.zoxide.list()<cr>", desc = "Zoxide List" },
    { "<leader>rat", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run All Tests in File" },
    { "<leader>rt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Run Test" },
    { "<leader>tb", "<cmd>TroubleToggle<cr>", desc = "Trouble Toggle" },
    { "<leader>tt", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree Toggle" },
    { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Goto Preview Implementation" },
    { "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Goto Preview References" },
    { "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Goto Preview Type Definition" },
}, { mode = "n" })

-- FTerm keymaps
vim.keymap.set('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true })
vim.keymap.set('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { noremap = true })
