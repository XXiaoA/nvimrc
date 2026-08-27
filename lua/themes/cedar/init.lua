--- Cedar colorscheme entry point (light-only).
local M = {}

--- Apply the colorscheme.
function M.load()
    vim.o.background = "light"
    vim.g.colors_name = "cedar"

    require("themes.cedar.groups").apply()

    local term = require("themes.cedar.palette").term
    for idx = 0, 15 do
        vim.g["terminal_color_" .. idx] = term[idx + 1]
    end

    vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor25-Cursor"
end

return M
