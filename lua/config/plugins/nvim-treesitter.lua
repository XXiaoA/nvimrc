return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = {
                "comment",
                "markdown_inline",
                "markdown",
                "vim",
                "lua",
                "python",
                "rust",
                "fish",
                "cpp",
                "vimdoc",
                "yaml",
                "yuck",
            },
            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = false,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "gnn",
                    node_decremental = "grc",
                    scope_incremental = "grm",
                },
            },
            indent = { enable = false },
            matchup = {
                enable = true, -- mandatory, false will disable the whole extension
                include_match_words = true,
                -- disable = { "c", "ruby" },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "hiphish/rainbow-delimiters.nvim",
        event = "BufReadPre",
        dependencies = "nvim-treesitter",
        opts = {
            highlight = {
                "rainbowcol1",
                "rainbowcol2",
                "rainbowcol3",
                "rainbowcol4",
                "rainbowcol5",
                "rainbowcol6",
                "rainbowcol7",
            },
        },
        config = function(_, opts)
            require("rainbow-delimiters.setup").setup(opts)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        dependencies = "nvim-treesitter",
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

    {
        "mizlan/iswap.nvim",
        dependencies = "nvim-treesitter",
        event = "VeryLazy",
        opts = {},
    },

    {
        "mfussenegger/nvim-treehopper",
        dependencies = "nvim-treesitter",
        keys = {
            {
                mode = { "o", "x" },
                "m",
                ":lua require('tsht').nodes()<CR>",
                silent = true,
            },
        },
        config = function()
            local tsht = require("tsht")
            if tsht then
                tsht.config.hint_keys = { "h", "j", "f", "d", "g", "k", "l", "s", "a" }
            end
        end,
    },

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
