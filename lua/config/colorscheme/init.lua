vim.cmd([[
if has('termguicolors')
    set termguicolors
endif
]])

local utils = require("utils")
utils.changeColorscheme("nightfox")
vim.cmd("set background=dark")
