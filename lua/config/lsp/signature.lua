local lsp_signature = require("utils").requirePlugin("lsp_signature")
if not lsp_signature then
    return
end

lsp_signature.on_attach({
    bind = true,
    handler_opts = {
        border = "single",
    },
---@diagnostic disable-next-line: undefined-global
}, bufnr)
