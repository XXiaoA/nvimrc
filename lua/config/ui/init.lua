local colorscheme = require("core.colorscheme")
local utils = require("utils")
local add_colorscheme = colorscheme.add_colorscheme

-- 主题
add_colorscheme("gruvbox-material", { "sainnhe/gruvbox-material" })
add_colorscheme("nightfox", { "EdenEast/nightfox.nvim", run = ":NightfoxCompile" })
add_colorscheme("duskfox")
add_colorscheme("catppuccin", { "catppuccin/nvim", as = "catppuccin" })

local theme = utils.readConfig("color_scheme")
colorscheme.change_colorscheme(theme)
vim.cmd("set background=dark")
