local yamler = require("utils.yamler")

return {
    {
        "neovim/nvim-lspconfig",
        -- TODO: prefect lazy load
        event = "BufReadPre",
        ---@diagnostic disable-next-line: param-type-mismatch
        ft = vim.tbl_keys(yamler.get_value("lsp")),
        dependencies = {
            "mason.nvim",
            "mason-lspconfig.nvim",
            "null-ls.nvim",
            "simrat39/rust-tools.nvim",
        },
    },

    {
        "williamboman/mason.nvim",
        branch = "main",
        opts = {
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
                    -- TODO: prefect lazy load
                    ---@diagnostic disable-next-line: param-type-mismatch
                    ensure_installed = vim.tbl_values(yamler.get_value("lsp")),
                })
            end

            require("config.lsp.setup")
        end,
    },

    {
        -- TODO: perfect it
        -- workspace library for sumneko_lua
        "ii14/emmylua-nvim",
    },

    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        opts = {
            sources = {
                ["null-ls"] = {
                    ignore = true,
                },
            },
        },
    },

    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },
}
