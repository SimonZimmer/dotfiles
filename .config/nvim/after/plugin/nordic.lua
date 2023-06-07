require('nordic').setup {
    theme='onedark',
    onedark = {
        brighter_whites = true,
    },
    bright_border = false,
    telescope = {
        style = 'flat',
    },
    nordic = {
        reduced_blue = true,
    },
    bold_keywords = false,
    italic_comments = true,
    transparent_bg = false,
    cursorline = {
        theme = 'flat',
        bold = false,
    },
    noice = {
        style = 'classic',
    },
}

-- Load the scheme.
vim.cmd.colorscheme 'nordic'
