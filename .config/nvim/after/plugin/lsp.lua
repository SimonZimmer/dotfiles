local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
	'sumneko_lua',
    'clangd',
    'pylsp',
    'cmake',
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.name == "eslint" then
		vim.cmd.LspStop('eslint')
		return
	end

	vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<leader>h", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", '<leader>gh', '<cmd>ClangdSwitchSourceHeader<cr>')
end)

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp.setup()
