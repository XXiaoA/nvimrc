vim.diagnostic.config({
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_text = {
        spacing = 4,
        prefix = "●",
    },
    signs = { text = { ERROR = "󰅚", WARN = "󰀪", HINT = "󰌶", INFO = "󰋽" } },
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true,
        max_width = 100,
        header = { "  Diagnostics", "Bold" },
        prefix = function(ctx)
            local severity = vim.diagnostic.severity[ctx.severity]
            return "  ", "Diagnostic" .. severity
        end,
    },
})

local function rename()
    if pcall(require, "inc_rename") then
        return ":IncRename "
    else
        vim.lsp.buf.rename()
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ctx)
        local map = require("core.keymap").set
        local nmap = map("n")
        -- stylua: ignore start
        nmap("go", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
        nmap("gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
        nmap("gr", vim.lsp.buf.references, { desc = "References" })
        nmap("gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
        nmap("gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
        nmap("gt", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })
        nmap("gK",  function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, { desc = "Signature Help" })
        nmap("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next Diagnostic" })
        nmap("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev Diagnostic" })
        map({ "n", "v" })("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
        nmap("<leader>rn", rename, { expr = true, desc = "Rename" })
        nmap("K", function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end, { buffer = ctx.buf })
        -- stylua: ignore end

        vim.lsp.on_type_formatting.enable()
        vim.lsp.inlay_hint.enable(false)
        vim.api.nvim_create_user_command("InlayHintToggle", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, {})
    end,
})

vim.lsp.enable({
    "lua_ls",
    "basedpyright",
    "clangd",
    "vimls",
    "rust_analyzer",
})
