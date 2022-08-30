vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
    compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
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
