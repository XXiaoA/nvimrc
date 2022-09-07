local colorscheme = require("core.colorscheme")
local utils = require("utils")
local add_colorscheme = colorscheme.add_colorscheme
local use = require("core.packer").add_plugin

-- colorscheme
add_colorscheme("gruvbox-material", { "sainnhe/gruvbox-material" })
add_colorscheme("nightfox", { "EdenEast/nightfox.nvim", run = ":NightfoxCompile" })
add_colorscheme("duskfox")
add_colorscheme("catppuccin", { "catppuccin/nvim", as = "catppuccin" })

local theme = utils.readConfig("color_scheme")
colorscheme.load_colorscheme(theme)
vim.cmd("set background=dark")

use({
    "kyazdani42/nvim-web-devicons",
    event = "BufEnter",
})

-- 状态栏
use({
    "nvim-lualine/lualine.nvim",
    event = "BufWinEnter",
    config = "require('config.ui.lualine')",
})

-- 缩进线
use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufWinEnter",
    config = "require('config.ui.indent-blankline')",
})

-- neo-tree
use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    event = "BufWinEnter",
    config = "require('config.ui.neo-tree')",
})

-- 启动页
use({
    "glepnir/dashboard-nvim",
    event = "BufWinEnter",
    config = "require('config.ui.dashboard')",
})

-- bufferline
use({
    "akinsho/bufferline.nvim",
    event = "BufWinEnter",
    config = "require('config.ui.bufferline')",
})

-- dressing.nvim
use({
    "stevearc/dressing.nvim",
    after = "telescope.nvim",
    config = "require('config.ui.dressing')",
})