local mason_lspconfig = require("utils").require("mason-lspconfig")
local lspconfig = require("utils").require("lspconfig")
if not mason_lspconfig or not lspconfig then
    return
end

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { underline = true, update_in_insert = false }
)

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "single",
        source = "always",
        header = "",
        prefix = "",
    },
    signs = {
        active = signs,
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
})

local function on_attach(client, bufnr)
      require("config.lsp.keymaps").on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
capabilities.textDocument.completion = {
    completionItem = {
        commitCharactersSupport = true,
        deprecatedSupport = true,
        insertReplaceSupport = true,
        insertTextModeSupport = {
            valueSet = { 1, 2 },
        },
        labelDetailsSupport = true,
        preselectSupport = true,
        resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
        },
        snippetSupport = true,
        tagSupport = {
            valueSet = { 1 },
        },
    },
    completionList = {
        itemDefaults = {
            "commitCharacters",
            "editRange",
            "insertTextFormat",
            "insertTextMode",
            "data",
        },
    },
    contextSupport = true,
    dynamicRegistration = false,
    insertTextMode = 1,
}

local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local sumneko_lua_opts = vim.tbl_extend("force", opts, require("config.lsp.opts.sumneko_lua"))

local clangd_opts = opts
clangd_opts.capabilities.offsetEncoding = "utf-8"

require("config.lsp.null-ls").setup(opts)

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup(opts)
    end,

    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup(sumneko_lua_opts)
    end,

    ["clangd"] = function()
        lspconfig.clangd.setup(clangd_opts)
    end,

    ["rust_analyzer"] = function()
        require("rust-tools").setup({
            server = {
                on_attach = on_attach,
            },
        })
    end,
})
