return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "mason-lspconfig.nvim",
            "null-ls.nvim",
            "simrat39/rust-tools.nvim",
            "p00f/clangd_extensions.nvim",
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
            ensure_installed = { "lua_ls", "pyright", "vimls", "rust_analyzer", "clangd" },
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
            require("config.lsp.setup")
        end,
    },

    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
            sources = {
                ["null-ls"] = {
                    ignore = true,
                },
                ["pylsp"] = {
                    ignore = true,
                },
            },
        },
    },

    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        opts = {
            input_buffer_type = "dressing",
        },
    },
}
