--- Cedar color palette (light-only).
local palette = {}

palette.light = {
    bg = "#e0e4e6",
    bg_hl = "#d2d8dc", -- cursorline / folds / subtle fills
    bg_alt = "#e8ebec", -- floats / completion menus
    bg_dim = "#d9dee1", -- statusline / tabline / context bar
    fg = "#1f2328",
    fg_alt = "#4a525a",
    grey = "#6c757d", -- comments / muted text
    grey_dim = "#98a2a9", -- line numbers / NonText
    border = "#bcc4c9", -- float borders / win separators

    red = "#a3412f",
    orange = "#a04808",
    yellow = "#7d5b0e",
    green = "#2b7212", -- strings
    teal = "#286868", -- UI accent + function family
    blue = "#2f63b0", -- keywords / statements
    cyan = "#0b658e", -- tags / heading delimiters
    violet = "#7b48c4", -- preprocessor / macros / todos / titles

    on_accent = "#eef0f1", -- fg on top of accent backgrounds
    cursor = "#2e3439", -- kitty cursor color
    selection = "#b9c9da", -- visual selection
    search_bg = "#f0d98f",
    incsearch_fg = "#1f2328",
    incsearch_bg = "#e5b95f",
    diff_add_bg = "#d9e5d6",
    diff_change_bg = "#e9e2cf",
    diff_delete_bg = "#ecd9d3",
    diff_text_bg = "#cfdac3",
}

--- ANSI colors for :terminal, matching the kitty light palette.
palette.term = {
    "#2e3439",
    "#a3412f",
    "#3a703f",
    "#8a6417",
    "#2f63b0",
    "#7b48c4",
    "#2f7575",
    "#d0d6d9",
    "#525a60",
    "#a85c46",
    "#6c8c68",
    "#a37c2e",
    "#5a80a8",
    "#9a64a3",
    "#4f8485",
    "#f2f4f5",
}

---@return table<string, string> palette
function palette.get()
    return palette.light
end

---@return string[] terminal colors
function palette.get_term()
    return palette.term
end

return palette
