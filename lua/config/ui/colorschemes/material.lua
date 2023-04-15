require("material").setup({
    styles = {
        comments = { italic = true },
        strings = {},
        keywords = { italic = true },
        functions = {},
        variables = {},
        operators = {},
        types = {},
    },

    plugins = {
        "gitsigns",
        "indent-blankline",
        "nvim-cmp",
        "nvim-web-devicons",
        "telescope",
        "which-key",
    },

    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false, -- Hide the end-of-buffer lines
    },
})
