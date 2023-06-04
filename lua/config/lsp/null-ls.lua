local M = {
    "jose-elias-alvarez/null-ls.nvim",
}

function M.config()
    local nls = require("null-ls")
    nls.setup({
        debounce = 150,
        save_after_format = false,
        sources = {
            nls.builtins.formatting.stylua,
            nls.builtins.formatting.fish_indent,
            nls.builtins.formatting.clang_format,
            nls.builtins.formatting.black,
            -- nls.builtins.code_actions.gitsigns,
            -- nls.builtins.diagnostics.flake8,
        },
        root_dir = require("null-ls.utils").root_pattern(".git"),
        on_attach = function(client, bufnr)
            require("config.lsp.keymaps").on_attach(client, bufnr)
        end,
    })
end

return M
