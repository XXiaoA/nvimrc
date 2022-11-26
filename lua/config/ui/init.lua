local colorscheme = require("core.colorscheme")
local add_colorscheme = colorscheme.add_colorscheme
local utils = require("utils")
local theme = utils.read_config("color_scheme")
local use = require("core.packer").add_plugin
local nmap = require("core.keymap").nmap

-- colorscheme
use({
    "sainnhe/gruvbox-material",
    opt = true,
})
add_colorscheme("gruvbox-material")

use({
    "EdenEast/nightfox.nvim",
    run = ":NightfoxCompile",
    opt = true,
})
add_colorscheme({ "duskfox", "nightfox" }, "nightfox.nvim")

use({
    "catppuccin/nvim",
    as = "catppuccin",
    run = ":CatppuccinCompile",
    opt = true,
})
add_colorscheme("catppuccin")

add_colorscheme("random")

require("config.ui.autocmd")
colorscheme.load_colorscheme(theme)
vim.cmd("set background=dark")
nmap("<leader>cc", colorscheme.load_colorscheme_ui, { desc = "Change ColorScheme" })

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

-- file explorer
use({
    "kyazdani42/nvim-tree.lua",
    event = "BufWinEnter",
    config = function()
        require("config.ui.nvim-tree")
    end,
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

use({
    "folke/twilight.nvim",
    cmd = "Twilight",
    config = function()
        require("twilight").setup({})
    end,
})

use({
    "folke/zen-mode.nvim",
    keys = "<leader>z",
    config = function()
        require("config.ui.zen-mode")
    end,
})
