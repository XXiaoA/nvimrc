local mason = require("utils").requirePlugin("mason")
local mason_lspconfig = require("utils").requirePlugin("mason-lspconfig")
if not mason or not mason_lspconfig then
    return
end

mason_lspconfig.setup({})
mason.setup({
    ui = {
        border = "single",
    },
})

