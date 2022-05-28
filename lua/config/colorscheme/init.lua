vim.cmd([[
if has('termguicolors')
    set termguicolors
endif
]])

local theme = require("utils.colorscheme")
theme.changeColorscheme("nightfox")
vim.cmd("set background=dark")
