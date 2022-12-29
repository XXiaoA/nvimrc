local add_colorscheme = require("core.colorscheme").add_colorscheme
local use = require("core.pack").add_plugin

-- colorscheme
use({
    "sainnhe/gruvbox-material",
})
add_colorscheme("gruvbox-material")

use({
    "EdenEast/nightfox.nvim",
    build = ":NightfoxCompile",
})
add_colorscheme("duskfox", "nightfox")

use({
    "rose-pine/neovim",
    name = "rose-pine",
})
add_colorscheme("rose-pine")

use({
    "catppuccin/nvim",
    name = "catppuccin",
    build = ":CatppuccinCompile",
})
add_colorscheme("catppuccin-mocha", "catppuccin-macchiato")

add_colorscheme("random")

use({
    "kyazdani42/nvim-web-devicons",
    event = "BufEnter",
})

-- 状态栏
use({
    "nvim-lualine/lualine.nvim",
    event = "BufEnter",
    dependencies = "nvim-web-devicons",
    config = function()
        require("config.ui.lualine")
    end,
})

-- 缩进线
use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
        require("config.ui.indent-blankline")
    end,
})

-- file explorer
use({
    "kyazdani42/nvim-tree.lua",
    event = "BufEnter",
    dependencies = "nvim-web-devicons",
    config = function()
        require("config.ui.nvim-tree")
    end,
})

-- bufferline
use({
    "akinsho/bufferline.nvim",
    event = "BufEnter",
    dependencies = "nvim-web-devicons",
    config = function()
        require("config.ui.bufferline")
    end,
})

-- dressing.nvim
use({
    "stevearc/dressing.nvim",
    dependencies = { "telescope.nvim" },
    init = function()
        vim.ui.select = function(...)
            require("lazy").load({ plugins = { "dressing.nvim" } })
            return vim.ui.select(...)
        end
        vim.ui.input = function(...)
            require("lazy").load({ plugins = { "dressing.nvim" } })
            return vim.ui.input(...)
        end
    end,
    config = function()
        require("config.ui.dressing")
    end,
})

use({
    "folke/twilight.nvim",
    config = true,
})

use({
    "XXiaoA/zen-mode.nvim",
    keys = "<leader>zz",
    dev = false,
    config = function()
        require("config.ui.zen-mode")
    end,
})
