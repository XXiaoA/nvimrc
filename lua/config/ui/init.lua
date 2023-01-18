local add_colorscheme = require("core.colorscheme").add_colorscheme
add_colorscheme("random")

return {
    -- colorscheme
    {
        "sainnhe/everforest",
        init = function()
            add_colorscheme("everforest")
        end,
    },

    {
        "folke/tokyonight.nvim",
        init = function()
            add_colorscheme("tokyonight-storm", "tokyonight-moon")
        end,
    },

    {
        "sainnhe/gruvbox-material",
        init = function()
            add_colorscheme("gruvbox-material")
        end,
    },

    {
        "EdenEast/nightfox.nvim",
        build = ":NightfoxCompile",
        init = function()
            add_colorscheme("duskfox", "nightfox")
        end,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        init = function()
            add_colorscheme("rose-pine")
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        build = ":CatppuccinCompile",
        init = function()
            add_colorscheme("catppuccin-mocha", "catppuccin-macchiato")
        end,
    },

    -- plugins
    {
        "kyazdani42/nvim-web-devicons",
    },

    {
        "uga-rosa/ccc.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        "XXiaoA/zen-mode.nvim",
        dev = false,
        dependencies = {
            "folke/twilight.nvim",
            config = true,
        },
        keys = {
            { "<leader>zz", "<CMD>ZenMode<CR>" },
            { "<leader>zt", "<CMD>Twilight<CR>" },
        },
        opts = {
            plugins = {
                options = {
                    enabled = true,
                    showcmd = true,
                },
                twilight = { enabled = true },
                gitsigns = { enabled = true },
                tmux = { enabled = true },
            },
        },
    },
}
