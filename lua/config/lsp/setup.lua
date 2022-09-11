local mason_lspconfig = require("utils").requirePlugin("mason-lspconfig")
local lspconfig = require("utils").requirePlugin("lspconfig")
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
    width = 60,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    width = 60,
})

---@diagnostic disable-next-line: unused-local
local function on_attach(client, bufnr)
    -- keymap
    local nmap = require("core.keymap").set_keymap("n")
    -- nmap("<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
    nmap("<leader>rn", function()
        local lsprename = require("lspsaga.rename")
        lsprename:lsp_rename()
        nmap("q", function()
            lsprename:close_rename_win()
        end, { buffer = 0 })
    end, { buffer = bufnr })
    nmap("<space>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    nmap("gh", vim.lsp.buf.hover, { buffer = bufnr })
    -- nmap("gd", vim.lsp.buf.definition, { buffer = bufnr })
    nmap("gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = bufnr })
    nmap("gD", vim.lsp.buf.declaration, { buffer = bufnr })
    -- nmap("gi", vim.lsp.buf.implementation, { buffer = bufnr })
    nmap("gi", "<cmd>Telescope lsp_implementations<CR>", { buffer = bufnr })
    -- nmap("gr", vim.lsp.buf.references, { buffer = bufnr })
    nmap("gr", "<cmd>Telescope lsp_references<CR>", { buffer = bufnr })
    nmap("go", vim.diagnostic.open_float, { buffer = bufnr })
    nmap("gp", vim.diagnostic.goto_prev, { buffer = bufnr })
    nmap("gn", vim.diagnostic.goto_next, { buffer = bufnr })
    nmap("gk", vim.lsp.buf.signature_help, { buffer = bufnr })
    nmap("<leader>=", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { buffer = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local settings = {
    on_attach = on_attach,
    capabilities = capabilities,
    other_fields = ...,
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
                -- on_attach = function(_, bufnr) end,
            },
        })
    end,
})
