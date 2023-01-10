return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPre",
        opts = function()
            local tsc = require("utils").require("nvim-treesitter.configs")
            if not tsc then
                return
            end

            tsc.setup({
                ensure_installed = { "markdown", "vim", "lua", "python", "rust", "fish", "cpp" },
                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
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
            })
        end,
    },

    {
        "p00f/nvim-ts-rainbow",
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
}
