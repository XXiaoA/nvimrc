vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "gruvbox-material",
    -- floating popups
    command = [[
    hi FloatBorder guibg=#282828
    hi WinBar guibg=NONE
    ]],
})

local g = vim.g
-- option: hard, medium, soft
g.gruvbox_material_background = "medium"

-- options: 'grey background', 'green background', 'blue background', 'red background', 'reverse'
g.gruvbox_material_visual = "blue background"

g.gruvbox_material_better_performance = 1
g.gruvbox_material_enable_bold = 1
g.gruvbox_material_enable_italic = 1
-- vim.g.gruvbox_material_transparent_background = 1
g.gruvbox_material_disable_italic_comment = 0

-- option: 'default' 'mix' 'original'
g.gruvbox_material_statusline_style = "mix"

-- option: 'material' 'mix' 'original'
g.gruvbox_material_palette = "mix"

-- don't show the eob
g.gruvbox_material_show_eob = 0

g.gruvbox_material_diagnostic_virtual_text = "colored"

g.gruvbox_material_current_word = "grey background"
g.gruvbox_material_ui_contrast = "high"
