vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    command = [[
    hi! link TSNodeKey Keyword
    hi! link TSNodeUnmatched Comment

    hi! link MiniTrailspace Error

    hi! link ScrollViewCursor NonText
    hi! link ScrollViewSearch Search

    hi GitSignsAddInline guibg=#81b29a guifg=bg
    hi GitSignsChangeInline guibg=#dbc074 guifg=bg
    hi GitSign guibg=#c94f6d guifg=bg

    hi MatchBackground cterm=underline gui=underline
    hi MatchParen cterm=underline gui=underline
    hi MatchWord cterm=underline gui=underline
    hi MatchParenCur cterm=underline gui=underline
    hi MatchWordCur cterm=underline gui=underline

    hi link BlinkCmpMenu bg
    hi link BlinkCmpMenuBorder bg
    hi link BlinkCmpDoc bg
    hi link BlinkCmpDocBorder bg
    hi link BlinkCmpDocSeparator bg
    ]],
})
