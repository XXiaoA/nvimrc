return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
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
            ensure_installed = { "lua_ls", "pyright", "vimls", "rust_analyzer", "clangd" },
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
                ["pylsp"] = {
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

    {
        "lvimuser/lsp-inlayhints.nvim",
        event = "LspAttach",
        branch = "anticonceal",
        opts = {},
        config = function(_, opts)
            require("lsp-inlayhints").setup(opts)
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require("lsp-inlayhints").on_attach(client, args.buf)
                end,
            })
        end,
    },
}
