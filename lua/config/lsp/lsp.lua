local yamler = require("utils.yamler")
return {
    {
        "neovim/nvim-lspconfig",
        -- event = "BufReadPre",
        ---@diagnostic disable-next-line: param-type-mismatch
        ft = vim.tbl_keys(yamler.get_value("lsp")),
        dependencies = {
            "mason.nvim",
            "mason-lspconfig.nvim",
            "simrat39/rust-tools.nvim",
        },
    },
    {
        "williamboman/mason.nvim",
        branch = "main",
        config = {
            ui = {
                border = "single",
            },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local mason_lspconfig = require("utils").require("mason-lspconfig")
            if mason_lspconfig then
                mason_lspconfig.setup({
                    ---@diagnostic disable-next-line: param-type-mismatch
                    ensure_installed = vim.tbl_values(yamler.get_value("lsp")),
                })
            end

            require("config.lsp.setup")
        end,
    },
}
