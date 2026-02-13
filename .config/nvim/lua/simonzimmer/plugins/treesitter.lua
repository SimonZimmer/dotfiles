return {
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPost", "BufNewFile" },
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { "yaml", "lua", "vim", "vimdoc", "query", "terraform", "hcl", "go", "gomod", "gowork", "gosum" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        disable = function(lang, buf)
          return lang == "helm"
        end,
      },
    }
  end
}
