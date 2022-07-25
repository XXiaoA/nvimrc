local lsp_signature = require("utils").requirePlugin("lsp_signature")
if not lsp_signature then
    return
end

lsp_signature.setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
        border = "single",
    },
})
