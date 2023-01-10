vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "duskfox",
    command = "hi NvimSurroundHighlight guibg=#39506d",
})
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "duskfox",
    command = [[
    hi IlluminatedWord ctermbg=237 guibg=#374145
    hi IlluminatedCurWord ctermbg=237 guibg=#374145
    hi IlluminatedWordText ctermbg=237 guibg=#374145
    hi IlluminatedWordRead ctermbg=237 guibg=#374145
    hi IlluminatedWordWrite ctermbg=237 guibg=#374145
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
