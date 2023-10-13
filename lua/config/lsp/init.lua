return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "mason-lspconfig.nvim",
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
            -- input_buffer_type = "dressing",
            post_hook = function()
                vim.fn.histdel("cmd", "^IncRename ")
            end,
        },
    },

    {
        "XXiaoA/aphrodite.nvim",
        dev = false,
        event = "LspAttach",
        opts = {
            lightbulb = {
                enable_in_insert = false,
                sign = false,
                virtual_text = true,
            },
        },
    },

    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>=",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                desc = "Format buffer",
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                cpp = { "clang_format" },
                fish = { "fish_indent" },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_fallback = true }
            end,
        },
        config = function(_, opts)
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                -- `FormatDisable!` will disable formatting just for this buffer
                if args.bang then
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })
            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = "Re-enable autoformat-on-save",
            })
            require("conform").setup(opts)
        end,
    },

    -- {
    --     "mfussenegger/nvim-lint",
    --     opts = {
    --         linters_by_ft = {
    --             -- lua = { "selene", "luacheck" },
    --             -- markdown = { "markdownlint" },
    --         },
    --     },
    -- },
}
