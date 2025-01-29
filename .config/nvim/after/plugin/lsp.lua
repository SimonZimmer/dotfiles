local lsp = require('lsp-zero')

-- Python
vim.g.python_host_prog = '/usr/local/bin/python'
vim.g.python3_host_prog = '~/.virtualenvs/neovim/bin/python'
lsp.on_attach(function(client, bufnr)
    -- Remove the <Space>h mapping in insert mode
    vim.api.nvim_buf_del_keymap(bufnr, "i", "<Space>h")
end)

-- CPP
require'lspconfig'.clangd.setup{}

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.name == "eslint" then
		vim.cmd.LspStop('eslint') return
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

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    window = {
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    },
    {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pylsp'].setup {
  capabilities = capabilities
}

local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      ellipsis_char = '...',
    })
  }
}

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        -- Remove <Space>h in insert mode for all LSPs
        vim.api.nvim_buf_del_keymap(bufnr, "i", "<Space>h")
    end,
})

-- Function to run clang-format on buffer write
local function format_with_clang()
  local clang_format_path = vim.fn.glob("/Users/simonzimmermann/.config/**/.clang-format")
  if clang_format_path == "" then
    vim.notify("Error: .clang-format file not found", vim.log.levels.ERROR)
    return
  end
  -- Construct clang-format command
  local clang_format_cmd = "clang-format -i --style=file:" .. clang_format_path
  local file_path = vim.fn.expand("%:p")
  local cmd = clang_format_cmd .. " " .. file_path

  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Error running clang-format: " .. result, vim.log.levels.ERROR)
    return
  end
  -- Reload the buffer to reflect the changes made by clang-format
  vim.cmd("checktime")
end

vim.api.nvim_create_augroup("ClangFormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "ClangFormatOnSave",
  pattern = { "*.h", "*.cpp", "*.c" },
  callback = format_with_clang,
})
