vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "rose-pine",
    command = [[
    hi IlluminatedWord ctermbg=237 guibg=#57406b
    hi IlluminatedCurWord ctermbg=237 guibg=#57406b
    hi IlluminatedWordText ctermbg=237 guibg=#57406b
    hi IlluminatedWordRead ctermbg=237 guibg=#57406b
    hi IlluminatedWordWrite ctermbg=237 guibg=#57406b
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
