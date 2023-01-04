vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "duskfox",
    command = "hi NvimSurroundHighlight guibg=#39506d",
})
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "duskfox",
    command = [[
    hi IlluminatedWord guibg=#575860
    hi IlluminatedCurWord guibg=#575860
    hi IlluminatedWordText guibg=#575860
    hi IlluminatedWordRead guibg=#575860
    hi IlluminatedWordWrite guibg=#575860
    ]],
})

require("nightfox").setup({
    options = {
        styles = {
            comments = "italic",
            -- conditionals = "italic",
            constants = "NONE",
            -- functions = "bold",
            keywords = "italic",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
        },
    },
})
