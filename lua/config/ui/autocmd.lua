vim.api.nvim_create_autocmd("ColorScheme", {
    command = [[
    hi! link TSNodeKey HopNextKey
    hi! link TSNodeUnmatched HopUnmatched
    ]],
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
--     pattern = "*",
--     command = [[
--     hi GitSignsChangeInline guibg=fg guifg=bg
--     hi GitSignsAddInline guibg=fg guifg=bg
--     hi GitSignsDeleteInline guibg=fg guifg=bg
--     ]],
-- })
