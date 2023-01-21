return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPre",
        opts = {
            ensure_installed = {
                "markdown_inline",
                "markdown",
                "vim",
                "lua",
                "python",
                "rust",
                "fish",
                "cpp",
                "help",
                "yaml",
            },
            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
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
        "mrjones2014/nvim-ts-rainbow",
        event = "BufReadPre",
        dependencies = "nvim-treesitter",
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
        "ckolkey/ts-node-action",
        dependencies = {
            "nvim-treesitter",
            "vim-repeat",
        },
        keys = {
            {
                "<leader>tn",
                function()
                    require("ts-node-action").node_action()
                end,
                { desc = "Trigger Node Action" },
            },
        },
        config = true,
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
            local tsht = require("utils").require("tsht")
            if tsht then
                tsht.config.hint_keys = { "h", "j", "f", "d", "g", "k", "l", "s", "a" }
            end
        end,
    },
}
