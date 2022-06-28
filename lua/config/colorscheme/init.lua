local utils = require("utils")

theme = utils.readConfig("color_scheme")
utils.changeColorscheme(theme)
vim.cmd("set background=dark")
