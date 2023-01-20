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

local autoformat = true
vim.api.nvim_create_user_command("AutoFormatToggle", function()
    autoformat = not autoformat
    vim.notify("Format on save: " .. tostring(autoformat))
end, {})

local function format()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.bo[buf].filetype
    local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

    vim.lsp.buf.format({
        bufnr = buf,
        filter = function(client)
            if have_nls then
                return client.name == "null-ls"
            end
            return client.name ~= "null-ls"
        end,
    })
end

local function on_attach(client, bufnr)
    local nmap = require("core.keymap").nmap

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
            buffer = bufnr,
            callback = function()
                if autoformat then
                    format()
                end
            end,
        })
        nmap("<leader>=", format, { buffer = bufnr, desc = "Format" })
    end

    nmap("<leader>rn", function()
        require("inc_rename")
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })
    nmap("<space>ca", "<cmd>Lspsaga code_action<CR>", { buffer = bufnr, desc = "Lsp code action" })
    nmap("gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = bufnr, desc = "Lsp definition" })
    nmap("gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Lsp declaration" })
    nmap("gp", "<cmd>Lspsaga peek_definition<CR>")
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
