local mason = require("utils").requirePlugin("mason")
local mason_lspconfig = require("utils").requirePlugin("mason-lspconfig")
if not mason or not mason_lspconfig then
    return
end

mason_lspconfig.setup({
    ensure_installed = {
        "sumneko_lua",
        "pylsp",
        "rust_analyzer",
        "vimls",
    },
})

mason.setup({
    ui = {
        border = "single",
    },
})
