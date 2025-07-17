---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            hint = {
                enable = true,
                arrayIndex = "Disable",
                paramName = "Literal",
                setType = true,
            },
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
            },
            codelens = {
                enable = true,
            },
            completion = {
                callSnippet = "Disable",
            },
            telemetry = { enable = false },
        },
    },
}
