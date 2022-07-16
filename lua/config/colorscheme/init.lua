local utils = require("utils")
local use = require("core.packer").add_plugin

-- 主题
use({ "sainnhe/gruvbox-material" })
use({ "EdenEast/nightfox.nvim", tag = "v1.0.0" })

theme = utils.readConfig("color_scheme")
utils.changeColorscheme(theme)
vim.cmd("set background=dark")
