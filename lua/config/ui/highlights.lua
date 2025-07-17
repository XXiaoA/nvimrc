vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    command = [[
    hi! link TSNodeKey Keyword
    hi! link TSNodeUnmatched Comment
    ]],
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    command = [[
    hi! link MiniTrailspace Error
    ]],
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    command = [[
    hi! link ScrollViewCursor NonText
    hi! link ScrollViewSearch Search
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

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    command = [[
    hi MatchBackground cterm=underline gui=underline
    hi MatchParen cterm=underline gui=underline
    hi MatchWord cterm=underline gui=underline
    hi MatchParenCur cterm=underline gui=underline
    hi MatchWordCur cterm=underline gui=underline
    ]],
})
