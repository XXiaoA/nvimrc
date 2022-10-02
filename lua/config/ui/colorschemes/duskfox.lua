vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "duskfox",
    command = "hi NvimSurroundHighlight guibg=#39506d",
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
