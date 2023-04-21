require'nvim-treesitter.configs'.setup {
  ensure_installed = {'cpp', 'c', 'python', 'rust', 'lua'},
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
