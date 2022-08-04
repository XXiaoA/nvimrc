local colorscheme = require("core.colorscheme")
local utils = require("utils")
local use = colorscheme.add_colorscheme

-- 主题
use("gruvbox-material", { "sainnhe/gruvbox-material" })
use("nightfox", { "EdenEast/nightfox.nvim", run = ":NightfoxCompile" })
use("catppuccin", { "catppuccin/nvim", as = "catppuccin" })

local theme = utils.readConfig("color_scheme")
colorscheme.change_colorscheme(theme)
vim.cmd("set background=dark")
