---@diagnostic disable: assign-type-mismatch
return {
    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },

    {
        "nvim-lua/plenary.nvim",
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
        config = true,
    },

    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },

    {
        "tpope/vim-sleuth",
        event = { "BufNewFile", "BufReadPost", "BufFilePost" },
    },

    {
        "dstein64/vim-win",
        keys = { { "<leader>w", desc = "Window manager" } },
        cmd = "Win",
        config = function()
            vim.g.win_ext_command_map = {
                ["="] = "wincmd =",
                q = "Win#exit",
            }
        end,
    },

    {
        "windwp/nvim-spectre",
        dependencies = "plenary.nvim",
        cmd = "Spectre",
        config = true,
    },

    {
        "gpanders/nvim-parinfer",
        enabled = false,
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
                    -- Disable brackets alias in favor of builtin block textobject
                    b = false,

                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    F = ai.gen_spec.treesitter(
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
                c = "Class",
                f = "Function call",
                F = "Function definition",
                o = "Block, conditional, loop",
                q = "Quote `, \", '",
                t = "Tag",
            }
            local a = vim.deepcopy(i)
            for k, v in pairs(a) do
                a[k] = v:gsub(" including.*", "")
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
        "echasnovski/mini.animate",
        event = "VeryLazy",
        opts = function()
            -- don't use animate when scrolling with the mouse
            local mouse_scrolled = false
            for _, scroll in ipairs({ "Up", "Down" }) do
                local key = "<ScrollWheel" .. scroll .. ">"
                vim.keymap.set({ "", "i" }, key, function()
                    mouse_scrolled = true
                    return key
                end, { expr = true })
            end

            local animate = require("mini.animate")
            return {
                resize = {
                    timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
                },
                scroll = {
                    timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
                    subscroll = animate.gen_subscroll.equal({
                        predicate = function(total_scroll)
                            if mouse_scrolled then
                                mouse_scrolled = false
                                return false
                            end
                            return total_scroll > 1
                        end,
                    }),
                },
            }
        end,
    },

    {
        "aserowy/tmux.nvim",
        cond = vim.env.TMUX ~= nil,
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
