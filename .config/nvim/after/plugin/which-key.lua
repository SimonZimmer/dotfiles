local wk = require("which-key")

wk.register({
    ["<leader>tb"] = {"<cmd>TroubleToggle<cr>", '[t]oggle trou[b]le' },
    ["-"] = {"<cmd>Oil<cr>", "Open parent directory" },
    ["<leader>ff"] = {"<cmd>lua require('telescope.builtin').find_files()<cr>", "[f]ind [f]iles" },
    ["<leader>fh"] = {"<cmd>lua require('telescope.builtin').help_tags()<cr>", "[f]ind [h]elp" },
    ["<leader>fg"] = {"<cmd>lua require('telescope.builtin').live_grep()<cr>", "[f]ind by [g]rep" },
    ["<leader>fd"] = {"<cmd>lua require('telescope.builtin').diagnostics()<cr>", "[f]ind [d]iagnostics" },
    ["<leader>fz"] = {"<cmd>lua require('telescope').extensions.zoxide.list()<cr>", "[f]ind [z]oxide" },
    ["<leader>fk"] = {"<cmd>lua require('telescope.builtin').keymaps()<cr>", "[f]ind [k]eymaps" },
    ["<leader>ft"] = {"<cmd>TodoTelescope<cr>", "[f]ind [t]o do" },
    ['<leader>tt'] = {"<cmd>NvimTreeToggle<cr>", "[T]oggle [T]ree" },
    ["<leader>b"] = {"<cmd>BlamerToggle<cr>", "git [b]lame" },
    ["<leader>cp"] = {"<cmd>Copilot panel<cr>", "[c]opilot [p]anel" },
    ["<leader>rt"] = {"<cmd>lua require('neotest').run.run()<cr>", "[r]un [t]est" },
    ["<leader>rat"] = {"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "[r]un [a]ll [t]ests"},
    ["gp"] = {"<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "[g]o to [p]review definition"},
    ["gpt"] = {"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "[g]o to [p]review [t]ype definition"},
    ["gpi"] = {"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "[g]o to [p]review [i]mplementation"},
    ["gP"] = {"<cmd>lua require('goto-preview').close_all_win()<CR>", "close [g]o to [P]review"},
    ["gpr"] = {"<cmd>lua require('goto-preview').goto_preview_references()<CR>", "[g]o to [p]review [r]eferences"},
})
