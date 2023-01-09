return {
    {
        -- workspace library for sumneko_lua
        "ii14/emmylua-nvim",
    },

    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        config = {
            sources = {
                ["null-ls"] = {
                    ignore = true,
                },
            },
        },
    },

    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },
}
