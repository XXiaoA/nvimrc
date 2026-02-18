return {
    "stevearc/dressing.nvim",
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
    opts = {
        input = {
            mappings = {
                -- n for normal mode
                n = {
                    q = "Close",
                },
            },
        },
        select = {
            backend = { "fzf_lua", "telescope", "fzf", "builtin", "nui" },
            fzf_lua = {
                winopts = {
                    height = 0.6,
                },
            },
            builtin = {
                mappings = {
                    q = "Close",
                },
            },
        },
    },
}
