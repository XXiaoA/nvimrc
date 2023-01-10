vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "nightfox",
    command = "hi NvimSurroundHighlight guibg=#4b4673",
})
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "nightfox",
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
