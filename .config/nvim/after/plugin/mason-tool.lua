require('mason-tool-installer').setup {
  ensure_installed = {
    'python-lsp-server',
    'pyright',
    'clangd',
    'cmake-language-server'
  },

  auto_update = false,
  run_on_start = true,
  start_delay = 3000,
}
