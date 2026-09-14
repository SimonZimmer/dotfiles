vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

if vim.fn.has("mac") == 1 then
	vim.g.clipboard = {
		name = "macos",
		copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
		paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
		cache_enabled = 0,
	}
elseif vim.fn.executable("win32yank.exe") == 1 then
	-- WSL has no WSLg/X server, so xclip can't reach the Windows clipboard.
	-- win32yank.exe bridges the unnamedplus register to the real Windows clipboard.
	vim.g.clipboard = {
		name = "win32yank",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end
vim.opt.clipboard = 'unnamedplus'

vim.opt.swapfile = false

vim.opt.laststatus = 3

vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10

vim.opt.autoread = true
vim.opt.mouse = 'a'

vim.lsp.log.set_level("off")

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
