return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  build = ':TSUpdate',
  config = function()
    -- Force x86_64 architecture for compilation to match the x86_64 Neovim executable
    vim.env.CC = "clang -arch x86_64"
    vim.env.CXX = "clang++ -arch x86_64"
    require'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "yaml", "lua", "vim", "vimdoc", "query", "terraform", "hcl",
        "go", "gomod", "gowork", "gosum",
        "css", "html", "javascript", "latex", "regex", "scss",
        "svelte", "tsx", "typst", "vue", "norg",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          return lang == "helm"
        end,
      },
    }
  end
}
