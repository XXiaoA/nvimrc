local M = {}

M.change_colorscheme = function(colorscheme)
    -- the theme has lualine's colorscheme
    local lualine_theme = {"nightfox", "gruvbox-material"}

    if vim.tbl_contains(lualine_theme, colorscheme) then
        local lualine = require("utils").requirePlugin("lualine")
        lualine.setup {options = {theme = colorscheme}}
    end
    -- vim.g.colors_name = colorscheme
    pcall(require, "colorscheme/" .. colorscheme)
    pcall(vim.cmd, "colorscheme " .. colorscheme)
end

M.change_background = function(background)
    pcall(vim.cmd, "set background=" .. background)
end

return M
