return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        {
            "<M-m>",
            function()
                require("oil").open()
            end,
            desc = "Open parent directory",
        },
    },
    opts = {
        keymaps = {
            ["q"] = "actions.close",
            ["<M-m>"] = "actions.close",
        },
        view_options = {
            show_hidden = true,
        },
    },
}
