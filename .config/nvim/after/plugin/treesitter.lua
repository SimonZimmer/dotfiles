require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "cpp", "rust" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
