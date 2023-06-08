return {
    {
        "tpope/vim-repeat",
    },

    {
        "nvim-lua/plenary.nvim",
    },

    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        config = true,
    },

    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },

    {
        "windwp/nvim-spectre",
        dependencies = "plenary.nvim",
        cmd = "Spectre",
        config = true,
    },

    {
        "gpanders/nvim-parinfer",
        enabled = true,
        lazy = false,
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
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter(
                        { a = "@function.outer", i = "@function.inner" },
                        {}
                    ),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
            -- register all text objects with which-key
            local i = {
                [" "] = "Whitespace",
                ['"'] = 'Balanced "',
                ["'"] = "Balanced '",
                ["`"] = "Balanced `",
                ["("] = "Balanced (",
                [")"] = "Balanced ) including white-space",
                [">"] = "Balanced > including white-space",
                ["<lt>"] = "Balanced <",
                ["]"] = "Balanced ] including white-space",
                ["["] = "Balanced [",
                ["}"] = "Balanced } including white-space",
                ["{"] = "Balanced {",
                ["?"] = "User Prompt",
                _ = "Underscore",
                a = "Argument",
                b = "Balanced ), ], }",
                c = "Class",
                f = "Function",
                o = "Block, conditional, loop",
                q = "Quote `, \", '",
                t = "Tag",
            }
            local a = vim.deepcopy(i)
            for k, v in pairs(a) do
                a[k] = v:gsub(" including.*", "")
            end

            local ic = vim.deepcopy(i)
            local ac = vim.deepcopy(a)
            for key, name in pairs({ n = "Next", l = "Last" }) do
                i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
                a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
            end
            require("which-key").register({
                mode = { "o", "x" },
                i = i,
                a = a,
            })
        end,
    },

    -- 运行时间
    { "dstein64/vim-startuptime", cmd = "StartupTime" },

    -- 中文文档
    { "yianwillis/vimcdoc", event = "VeryLazy" },

    -- 翻译
    { "voldikss/vim-translator", cmd = { "Translate", "TranslateW" } },

    {
        "danymat/neogen",
        keys = { { "<leader>/", "<cmd>Neogen<CR>", desc = "Generate annotation" } },
        cmd = "Neogen",
        opts = { snippet_engine = "luasnip" },
    },

    {
        "karb94/neoscroll.nvim",
        keys = {
            { "<C-u>", mode = { "n", "x" } },
            { "<C-d>", mode = { "n", "x" } },
            { "<C-b>", mode = { "n", "x" } },
            { "<C-f>", mode = { "n", "x" } },
            { "<C-y>", mode = { "n", "x" } },
            { "<C-e>", mode = { "n", "x" } },
            { "zt", mode = { "n", "x" } },
            { "zz", mode = { "n", "x" } },
            { "zb", mode = { "n", "x" } },
        },
        config = true,
    },

    {
        "aserowy/tmux.nvim",
        keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<A-h>", "<A-j>", "<A-k>", "<A-l>" },
        config = true,
    },

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "telescope.nvim", "nvim-lua/plenary.nvim" },
        keys = {
            {
                "<leader>ft",
                ":TodoTelescope cwd=" .. require("utils").get_root() .. "<CR>",
                silent = true,
            },
        },
        opts = {
            highlight = {
                keyword = "bg",
            },
        },
    },

    {
        "s1n7ax/nvim-window-picker",
        keys = {
            {
                "<leader>ww",
                function()
                    local picked_window_id = require("window-picker").pick_window({
                        include_current_win = false,
                        autoselect_one = true,
                    }) or vim.api.nvim_get_current_win()
                    vim.api.nvim_set_current_win(picked_window_id)
                end,
                desc = "Pick a window",
            },
            {
                "<leader>ws",
                function()
                    local window = require("window-picker").pick_window({
                        include_current_win = false,
                        autoselect_one = true,
                    })
                    local target_buffer = vim.fn.winbufnr(window)
                    -- Set the target window to contain current buffer
                    vim.api.nvim_win_set_buf(window, 0)
                    -- Set current window to contain target buffer
                    vim.api.nvim_win_set_buf(0, target_buffer)
                end,
                desc = "Swap windows",
            },
        },
        opts = {
            autoselect_one = true,
            include_current = false,
            filter_rules = {
                -- filter using buffer options
                bo = {
                    -- if the file type is one of following, the window will be ignored
                    filetype = {},
                    -- if the buffer type is one of following, the window will be ignored
                    buftype = {},
                },
            },
            other_win_hl_color = "#e35e4f",
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

    {
        "glacambre/firenvim",
        lazy = false,
        enabled = false,

        build = function()
            vim.fn["firenvim#install"](0)
        end,

        init = function()
            if vim.g.started_by_firenvim then
                vim.g.firenvim_config = {
                    localSettings = {
                        [".*"] = {
                            cmdline = "none",
                        },
                    },
                }
                vim.opt.laststatus = 0

                vim.api.nvim_create_autocmd("UIEnter", {
                    once = true,
                    callback = function()
                        vim.go.lines = 20
                    end,
                })
                vim.cmd("au BufEnter ybt.ssoier*.txt set filetype=cpp")
            end
        end,
    },
}
