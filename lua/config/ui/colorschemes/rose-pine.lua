vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "rose-pine",
    command = [[
    hi IlluminatedWord guibg=#6e6a86
    hi IlluminatedCurWord guibg=#6e6a86
    hi IlluminatedWordText guibg=#6e6a86
    hi IlluminatedWordRead guibg=#6e6a86
    hi IlluminatedWordWrite guibg=#6e6a86
    ]],
})

require("rose-pine").setup({
    --- @usage 'main' | 'moon'
    dark_variant = "moon",
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = false,
    disable_italics = false,
})
