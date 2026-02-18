---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        event = "VeryLazy",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "c",
                "comment",
                "cpp",
                "fish",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "rust",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
                "yuck",
                "zsh",
            })
        end,
    },

    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
    },

    {
        "hiphish/rainbow-delimiters.nvim",
        event = "BufReadPre",
        opts = {},
        config = function(_, opts)
            require("rainbow-delimiters.setup").setup(opts)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = {
            max_lines = 3,
        },
    },

    {
        "Wansmer/treesj",
        dependencies = "nvim-treesitter",
        keys = { { "<leader>J", "<cmd>TSJToggle<cr>", desc = "Join toggle" } },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },

    -- {
    --     "mizlan/iswap.nvim",
    --     dependencies = "nvim-treesitter",
    --     event = "VeryLazy",
    --     opts = {},
    -- },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter",
        init = function()
            -- PERF: no need to load the plugin, if we only need its queries for mini.ai
            local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local enabled = false
            if opts.textobjects then
                for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                    if opts.textobjects[mod] and opts.textobjects[mod].enable then
                        enabled = true
                        break
                    end
                end
            end
            if not enabled then
                require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
            end
        end,
    },
}
