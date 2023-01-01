local mason = require("utils").require("mason")
local mason_lspconfig = require("utils").require("mason-lspconfig")
if not mason or not mason_lspconfig then
    return
end

mason_lspconfig.setup({
    ensure_installed = {
        "sumneko_lua",
        "pylsp",
        "rust_analyzer",
        "vimls",
        "clangd",
    },
})

mason.setup({
    ui = {
        border = "single",
    },
})
