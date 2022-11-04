local mason_lspconfig = require("utils").require_plugin("mason-lspconfig")
local lspconfig = require("utils").require_plugin("lspconfig")
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
    -- disable format
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- keymap
    local nmap = require("core.keymap").nmap
    nmap("<leader>rn", function()
        local lsprename = require("lspsaga.rename")
        lsprename:lsp_rename()
        nmap("q", function()
            lsprename:close_rename_win()
        end, { buffer = 0 })
    end, { buffer = bufnr, desc = "Lsp rename" })
    nmap("<space>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Lsp code action" })
    nmap("gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = bufnr, desc = "Lsp definition" })
    nmap("gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Lsp declaration" })
    nmap(
        "gi",
        "<cmd>Telescope lsp_implementations<CR>",
        { buffer = bufnr, desc = "Lsp implementation" }
    )
    nmap("gr", "<cmd>Telescope lsp_references<CR>", { buffer = bufnr, desc = "Lsp references" })

    nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
    nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
    nmap("[e", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
    nmap("]e", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)
    nmap("go", "<cmd>Lspsaga show_line_diagnostics<CR>")

    nmap("gk", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Lsp open signature help" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local settings = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local lua_settings = vim.tbl_extend("force", settings, require("config.lsp.settings.sumneko_lua"))
mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup(settings)
    end,

    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup(lua_settings)
    end,

    ["rust_analyzer"] = function()
        require("rust-tools").setup({
            server = {
                on_attach = on_attach,
            },
        })
    end,
})
