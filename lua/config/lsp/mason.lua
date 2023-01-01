local mason = require("utils").require("mason")
local mason_lspconfig = require("utils").require("mason-lspconfig")
local yamler = require("utils.yamler")
if not mason or not mason_lspconfig then
    return
end

mason_lspconfig.setup({
    ---@diagnostic disable-next-line: param-type-mismatch
    ensure_installed = vim.tbl_values(yamler.get_value("lsp")),
})

mason.setup({
    ui = {
        border = "single",
    },
})
