return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },

                disable = { "miss-parameter", "missing-parameter" },
            },
            workspace = {
                library = {
                    vim.fn.stdpath("data") .. "/lazy/emmylua-nvim",
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
