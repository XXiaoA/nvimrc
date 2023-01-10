return {
    "stevearc/dressing.nvim",
    dependencies = "telescope.nvim",
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
            builtin = {
                mappings = {
                    q = "Close",
                },
            },
        },
    },
}
