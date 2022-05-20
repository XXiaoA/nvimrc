vim.cmd([[
if has('termguicolors')
    set termguicolors
endif
]])

local theme = require("utils.colorscheme")
theme.change_colorscheme("nightfox")
theme.change_background("back")
