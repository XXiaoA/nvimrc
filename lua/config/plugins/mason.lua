local mason = require("utils").requirePlugin("mason")
if not mason then
    return
end

mason.setup({
    ui = {
        border = "single",
    },
})

require("mason-lspconfig").setup({})
