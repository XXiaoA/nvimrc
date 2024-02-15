vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "everforest",
    command = [[
    hi FloatBorder guibg=#272E33
    hi WinBar guibg=NONE
    ]],
})

local g = vim.g
g.everforest_background = "hard"
g.everforest_better_performance = 1
g.everforest_enable_italic = 1
g.everforest_ui_contrast = "high"

g.everforest_enable_bold = 1
-- g.everforest_transparent_background = 1
g.everforest_disable_italic_comment = 0

-- option: 'default' 'mix' 'original'
g.everforest_statusline_style = "mix"

-- option: 'material' 'mix' 'original'

-- don't show the eob
g.everforest_show_eob = 0

g.everforest_diagnostic_virtual_text = "colored"

g.everforest_current_word = "grey background"
