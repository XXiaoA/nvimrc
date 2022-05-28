local M = {}

M.changeColorscheme = function(colorscheme)
    -- the theme has lualine's colorscheme
    local lualine_theme = {"nightfox", "gruvbox-material"}

    if vim.tbl_contains(lualine_theme, colorscheme) then
        local lualine = require("utils").requirePlugin("lualine")
        lualine.setup {options = {theme = colorscheme}}
    end

    if colorscheme then
        pcall(require, "colorscheme/" .. colorscheme)
        pcall(vim.cmd, "colorscheme " .. colorscheme)
    end
end

return M
