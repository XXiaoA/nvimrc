require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    styles = {
        comments = { "italic" },
        -- conditionals = { "italic" },
        loops = {},
        -- functions = { "bold" },
        keywords = { "italic" },
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
        dropbar = {
            enabled = true,
            color_mode = false, -- enable color for kind's texts, not just kind's icons
        },
        illuminate = {
            enabled = true,
            lsp = false,
        },
        noice = true,
        fidget = true,
        cmp = true,
        semantic_tokens = true,
        ufo = true,
        mason = true,
        leap = true,
        markdown = true,
        treesitter = true,
        treesitter_context = true,
        rainbow_delimiters = true,
        telescope = true,
        which_key = true,
        dashboard = true,
        ts_rainbow = true,
        hop = true,
        aerial = true,
    },
})
