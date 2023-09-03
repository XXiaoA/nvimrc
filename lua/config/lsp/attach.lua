local M = {}

function M.get_keymaps()
    -- stylua: ignore start
    return {
        { "go", vim.diagnostic.open_float, desc = "Line Diagnostics" },
        { "gd",  function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition" },
        { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
        { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
        { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
        { "gt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true  }) end, desc = "Goto Type Definition" },
        { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
        { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
        { "gp", "<CMD>Aphrodite peek_definition<CR>", "Peek definition" },
        { "gP", "<CMD>Aphrodite peek_type_definition<CR>", "Peek type definition" },
        { "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
        { "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
        { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
        { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
        { "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
        { "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
        { "<leader>=", M.format, desc = "Format", has = "documentFormatting" },
        { "<leader>=", M.format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" },
        { "<leader>rn", M.rename, expr = true, desc = "Rename", has = "rename" },
    }
    -- stylua: ignore end
end

function M.format()
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

function M.rename()
    if pcall(require, "inc_rename") then
        return ":IncRename " .. vim.fn.expand("<cword>")
    else
        vim.lsp.buf.rename()
    end
end

function M.diagnostic_goto(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    local mini_animate = require("mini.animate")
    return function()
        go({ severity = severity })
        mini_animate.execute_after("scroll", function()
            vim.defer_fn(vim.diagnostic.open_float, 10)
        end)
    end
end

function M.on_attach(client, buffer)
    local Keys = require("lazy.core.handler.keys")
    local keymaps = {}

    for _, value in ipairs(M.get_keymaps()) do
        local keys = Keys.parse(value)
        if keys[2] == vim.NIL or keys[2] == false then
            keymaps[keys.id] = nil
        else
            keymaps[keys.id] = keys
        end
    end

    for _, keys in pairs(keymaps) do
        if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
            local opts = Keys.opts(keys)
            opts.has = nil
            opts.silent = true
            opts.buffer = buffer
            vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
        end
    end

    -- auto format
    M.autoformat = true
    vim.api.nvim_create_user_command("AutoFormatToggle", function()
        M.autoformat = not M.autoformat
        vim.notify("Format on save: " .. tostring(M.autoformat))
    end, {})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormat." .. buffer, {}),
            buffer = buffer,
            callback = function()
                if M.autoformat then
                    M.format()
                end
            end,
        })
    end

    -- inlay hint
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint(buffer, true)
        vim.api.nvim_create_user_command("InlayHintToggle", function()
            vim.lsp.inlay_hint(buffer, nil)
        end, {})
    end

    -- disable treesitter highlight if has semantic highlight
    if client.server_capabilities.semanticTokensProvider then
        vim.cmd("TSDisable highlight")
    end
end

return M
