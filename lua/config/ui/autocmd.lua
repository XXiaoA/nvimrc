vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    command = [[
    hi! link TSNodeKey HopNextKey
    hi! link TSNodeUnmatched HopUnmatched
    ]],
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    command = [[
    hi GitSignsAddInline guibg=#81b29a guifg=bg
    hi GitSignsChangeInline guibg=#dbc074 guifg=bg
    hi GitSign guibg=#c94f6d guifg=bg
    ]],
})
