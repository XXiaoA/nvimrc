return {
    {
        "neovim/nvim-lspconfig",
        event = "Filetype",
        dependencies = {
            "mason.nvim",
            "mason-lspconfig.nvim",
            "simrat39/rust-tools.nvim",
            "p00f/clangd_extensions.nvim",
        },
        config = function()
            require("config.lsp.setup")
        end,
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
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {},
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
        enabled = false,
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

    {
        "ofseed/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },

    {
        "RRethy/vim-illuminate",
        event = { "VeryLazy", "LspAttach" },
        config = function()
            require("illuminate").configure({
                delay = 200,
                modes_allowlist = { "n" },
                large_file_cutoff = 2000,
                large_file_overrides = {
                    providers = { "lsp" },
                },
            })
        end,
        keys = {
            {
                "]]",
                function()
                    require("illuminate").goto_next_reference()
                end,
                desc = "Next Reference",
            },
            {
                "[[",
                function()
                    require("illuminate").goto_prev_reference()
                end,
                desc = "Prev Reference",
            },
        },
    },
}
