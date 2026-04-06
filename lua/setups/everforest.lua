local function lighten(color, amount)
    local r = math.floor(color / 0x10000) % 0x100
    local g = math.floor(color / 0x100) % 0x100
    local b = color % 0x100
    r = math.floor(r + (0xFF - r) * amount)
    g = math.floor(g + (0xFF - g) * amount)
    b = math.floor(b + (0xFF - b) * amount)
    return r * 0x10000 + g * 0x100 + b
end

local function darken(color, amount)
    local r = math.floor(color / 0x10000) % 0x100
    local g = math.floor(color / 0x100) % 0x100
    local b = color % 0x100
    r = math.floor(r * (1 - amount))
    g = math.floor(g * (1 - amount))
    b = math.floor(b * (1 - amount))
    return r * 0x10000 + g * 0x100 + b
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "everforest",
    callback = function()
        vim.cmd([[
        hi FloatBorder guibg=#272E33
        hi WinBar guibg=NONE
        ]])

        local hl = vim.api.nvim_get_hl(0, { name = "DiffChange" })
        if hl.bg then
            local bg = vim.o.background == "light" and darken(hl.bg, 0.15) or lighten(hl.bg, 0.15)
            vim.api.nvim_set_hl(0, "DiffviewDiffText", { bg = bg, bold = false })
        end
    end,
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

-- don't show the eob
g.everforest_show_eob = 0

g.everforest_diagnostic_virtual_text = "colored"

g.everforest_current_word = "grey background"
