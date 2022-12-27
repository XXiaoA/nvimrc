local colorscheme = require("core.colorscheme")
local add_colorscheme = colorscheme.add_colorscheme
local get_value = require("utils.yamler").get_value
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
    "rose-pine/neovim",
    as = "rose-pine",
    opt = true,
})
add_colorscheme("rose-pine")

use({
    "catppuccin/nvim",
    as = "catppuccin",
    run = ":CatppuccinCompile",
    opt = true,
})
add_colorscheme({ "catppuccin-mocha", "catppuccin-macchiato" }, "catppuccin")

add_colorscheme("random")

require("config.ui.autocmd")
colorscheme.load_colorscheme(get_value("color_scheme"))
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
    opt = true,
    config = function()
        require("twilight").setup({})
    end,
})

use({
    "XXiaoA/zen-mode.nvim",
    keys = "<leader>zz",
    config = function()
        vim.cmd("PackerLoad twilight.nvim")
        require("config.ui.zen-mode")
    end,
})
