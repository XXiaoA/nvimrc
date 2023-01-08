local M = {
    "jose-elias-alvarez/null-ls.nvim",
}

function M.setup(options)
    local nls = require("null-ls")
    nls.setup({
        debounce = 150,
        save_after_format = false,
        sources = {
            nls.builtins.formatting.stylua,
            nls.builtins.formatting.fish_indent,
            -- nls.builtins.code_actions.gitsigns,
            -- nls.builtins.formatting.black,
            -- nls.builtins.diagnostics.flake8,
        },
        on_attach = options.on_attach,
        root_dir = require("null-ls.utils").root_pattern(".git"),
    })
end

return M
