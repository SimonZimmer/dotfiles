--local null_ls = require("null-ls")

--null_ls.setup({
--    sources = {
--        null_ls.builtins.formatting.black,
--        null_ls.builtins.diagnostics.flake8.with({extra_args = {"--max-line-length", "100"}}),
--    },
--})

--vim.api.nvim_command("autocmd BufWritePost *.py lua vim.lsp.buf.format()")