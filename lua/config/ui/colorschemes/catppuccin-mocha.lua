require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    float = {
        transparent = false,
        solid = false,
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
        colorful_winsep = {
            enabled = true,
            color = "blue",
        },
        dropbar = {
            enabled = true,
            color_mode = false, -- enable color for kind's texts, not just kind's icons
        },
        illuminate = {
            enabled = true,
            lsp = false,
        },
        nvim_surround = true,
        neotree = true,
        noice = true,
        notify = false,
        fidget = true,
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
        aerial = true,
        diffview = true,
        harpoon = true,
    },
})
