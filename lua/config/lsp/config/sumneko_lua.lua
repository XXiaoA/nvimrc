return {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },

                disable = { "miss-parameter" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = os.getenv("HOME")
                    .. "/.local/share/nvim/site/pack/packer/start/emmylua-nvim",
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
