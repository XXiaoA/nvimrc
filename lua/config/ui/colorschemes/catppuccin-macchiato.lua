require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        -- functions = { "bold" },
        -- keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        neotree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
        },
        lsp_saga = true,
        which_key = true,
        dashboard = true,
        ts_rainbow = true,
        hop = true,
        aerial = true,
    },
})
