---@diagnostic disable: assign-type-mismatch
return {
    {
        "tpope/vim-repeat",
    },

    {
        "nvim-lua/plenary.nvim",
    },

    {
        "AndrewRadev/linediff.vim",
        cmd = { "Linediff", "LinediffAdd", "LinediffMerge", "LinediffPick" },
    },

    {
        "notjedi/nvim-rooter.lua",
        event = { "BufRead", "BufEnter" },
        opts = true,
    },

    {
        "monaqa/dial.nvim",
        -- stylua: ignore
        keys = {
            { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
            { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.semver.alias.semver,
                    augend.date.alias["%Y/%m/%d"],
                    augend.constant.alias.bool,
                    augend.constant.new({ elements = { "and", "or" } }),
                    augend.constant.new({
                        elements = { "&&", "||" },
                        word = false,
                    }),
                },
            })
        end,
    },

    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {
            preview = {
                winblend = 5,
            },
        },
        dependencies = {
            "junegunn/fzf",
            build = function()
                vim.fn["fzf#install"]()
            end,
        },
    },

    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },

    {
        "rbong/vim-flog",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
    },

    {
        "tpope/vim-sleuth",
        event = { "BufNewFile", "BufReadPost", "BufFilePost" },
    },

    {
        "windwp/nvim-spectre",
        dependencies = "plenary.nvim",
        cmd = "Spectre",
        config = true,
    },

    {
        "gpanders/nvim-parinfer",
        ft = "yuck",
    },

    {
        "echasnovski/mini.move",
        keys = {
            { mode = { "n", "x" }, "<M-left>" },
            { mode = { "n", "x" }, "<M-right>" },
            { mode = { "n", "x" }, "<M-down>" },
            { mode = { "n", "x" }, "<M-up>" },
        },
        opts = {
            mappings = {
                -- Move visual selection in Visual mode.
                left = "<M-left>",
                right = "<M-right>",
                down = "<M-down>",
                up = "<M-up>",

                -- Move current line in Normal mode
                line_left = "<M-left>",
                line_right = "<M-right>",
                line_down = "<M-down>",
                line_up = "<M-up>",
            },
        },
    },

    {
        "echasnovski/mini.trailspace",
        event = "VeryLazy",
        config = true,
    },

    {
        "iamcco/markdown-preview.nvim",
        config = function()
            vim.g.mkdp_auto_close = 0
        end,
        build = "cd app && npm install",
        ft = "markdown",
    },

    -- session
    {
        "Shatur/neovim-session-manager",
        keys = {
            {
                "<leader>ss",
                "<cmd>SessionManager save_current_session<CR>",
                desc = "save session",
            },
            {
                "<leader>sl",
                "<cmd>SessionManager load_last_session<CR>",
                desc = "load last session",
            },
            { "<leader>sc", "<cmd>SessionManager load_session<CR>", desc = "load session" },
            { "<leader>sd", "<cmd>SessionManager delete_session<CR>", desc = "delete session" },
        },
        opts = function()
            return {
                autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
                autosave_last_session = false,
            }
        end,
    },

    { "junegunn/vim-easy-align", cmd = "EasyAlign" },

    -- better text-objects
    {
        "echasnovski/mini.ai",
        keys = {
            { "a", mode = { "x", "o" } },
            { "i", mode = { "x", "o" } },
        },
        dependencies = "nvim-treesitter-textobjects",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    -- Disable brackets alias in favor of builtin block textobject
                    b = false,

                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
    },

    -- calculate the startup time
    { "dstein64/vim-startuptime", cmd = "StartupTime" },

    -- translate
    {
        "voldikss/vim-translator",
        cmd = { "Translate", "TranslateW" },
        keys = {
            { "<leader>tw", "<cmd>TranslateW<CR>", desc = "Translate" },
            { mode = "x", "<leader>tw", ":<C-u>'<,'>TranslateW<CR>", silent = true, desc = "Translate" },
        },
    },

    {
        "danymat/neogen",
        keys = { { "<leader>/", "<cmd>Neogen<CR>", desc = "Generate annotation" } },
        cmd = "Neogen",
        opts = { snippet_engine = "luasnip" },
    },

    {
        "aserowy/tmux.nvim",
        keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<A-h>", "<A-j>", "<A-k>", "<A-l>" },
        config = true,
    },

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "plenary.nvim" },
        opts = {
            highlight = {
                keyword = "bg",
                after = "empty",
            },
        },
    },

    {
        "skywind3000/asyncrun.vim",
        cmd = "AsyncRun",
        config = function()
            local g = vim.g

            g.asyncrun_open = 6
            g.asyncrun_bell = 1
        end,
    },

    {
        "simnalamburt/vim-mundo",
        cmd = "MundoToggle",
    },

    {
        "andymass/vim-matchup",
        event = "BufReadPost",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
        end,
    },
}
