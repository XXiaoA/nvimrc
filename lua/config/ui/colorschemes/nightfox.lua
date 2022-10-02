vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "nightfox",
    command = "hi NvimSurroundHighlight guibg=#4b4673",
})

require("nightfox").setup({
    options = {
        styles = {
            comments = "italic",
            -- conditionals = "italic",
            constants = "NONE",
            -- functions = "bold",
            -- keywords = "italic",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
        },
    },
})
