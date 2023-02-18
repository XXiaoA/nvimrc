local yamler = require("utils.yamler")

return {
    {
        "neovim/nvim-lspconfig",
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
        keys = { { "<leader>om", "<cmd>Mason<CR>", desc = "Mason" } },
        opts = {
            ui = {
                border = "single",
            },
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ---@diagnostic disable-next-line: param-type-mismatch
            ensure_installed = vim.tbl_values(yamler.get_value("lsp")),
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
            require("config.lsp.setup")
        end,
    },

    {
        -- workspace library for lua_ls
        "ii14/emmylua-nvim",
    },

    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
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
