local use = require("core.pack").add_plugin

-- treesitter 高亮
use({
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPre",
    config = function()
        require("config.plugins.nvim-treesitter")
    end,
})

-- 彩色括号
use({
    "p00f/nvim-ts-rainbow",
    event = "BufReadPre",
    dependencies = "nvim-treesitter",
})

-- 按键
use({
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("config.plugins.which-key")
    end,
})

-- Comment 注释
use({
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } }, "gb", mode = { "n", "v" } },
    config = function()
        require("config.plugins.comment")
    end,
})

-- snippets
use({
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = "Comment.nvim",
    config = function()
        require("config.plugins.luasnip")
    end,
})

-- nvim-cmp
use({
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "LuaSnip",
    },
    config = function()
        require("config.plugins.cmp")
    end,
})

-- 自动补全括号
use({
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = "nvim-cmp",
    config = function()
        require("config.plugins.nvim-autopairs")
    end,
})

-- 文件搜索 预览 等
use({
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
    },
    cmd = "Telescope",
    config = function()
        require("config.plugins.telescope")
    end,
})

-- recent project
use({
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    dependencies = "telescope.nvim",
    config = function()
        require("config.plugins.project")
    end,
})

-- code outline
use({
    "stevearc/aerial.nvim",
    keys = { "[f", "]f", "<leader>aa", "<leader>fa" },
    config = function()
        require("config.plugins.aerial")
    end,
})

-- 颜色
use({
    "NvChad/nvim-colorizer.lua",
    cmd = "ColorizerAttachToBuffer",
    config = function()
        require("config.plugins.nvim-colorizer")
    end,
})

-- 命令行窗口
use({
    "akinsho/toggleterm.nvim",
    keys = { "<leader>tt", "<leader>tf", "<leader>ta" },
    config = function()
        require("config.plugins.toggleterm")
    end,
})

-- session
use({
    "Shatur/neovim-session-manager",
    keys = { "<leader>ss", "<leader>sl", "<leader>sc", "<leader>sd" },
    config = function()
        require("config.plugins.neovim-session-manager")
    end,
})

-- 自动对齐
use({ "junegunn/vim-easy-align", cmd = "EasyAlign" })

use({
    "kylechui/nvim-surround",
    keys = { "<C-g>s", "<C-g>S", "sa", "ssa", "sA", "ssA", "sa", "sA", "sd", "sr" },
    config = function()
        require("config.plugins.surround")
    end,
})

use({
    "XXiaoA/ns-textobject.nvim",
    -- Operator-pending mode
    event = "ModeChanged",
    dependencies = "nvim-surround",
    config = true,
})

-- 运行时间
use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

-- 快速转跳
use({
    "phaazon/hop.nvim",
    keys = {
        "<leader>hw",
        "<leader>hW",
        "<leader>hl",
        "<leader>hp",
        { "t", mode = { "n", "x", "o" } },
        { "T", mode = { "n", "x", "o" } },
        { "f", mode = { "n", "x", "o" } },
        { "F", mode = { "n", "x", "o" } },
        { "se", mode = { "n", "x", "o" } },
    },
    config = function()
        require("config.plugins.hop")
    end,
})

-- 中文文档
use({ "yianwillis/vimcdoc", event = "VeryLazy" })

-- 格式化代码
use({
    "mhartington/formatter.nvim",
    keys = "<leader>bf",
    config = function()
        require("config.plugins.formatter")
    end,
})

-- 翻译
use({ "voldikss/vim-translator", cmd = { "Translate", "TranslateW" } })

-- TODO: configure it! (with rust-tools)
-- Debugging
-- use({ "mfussenegger/nvim-dap" })
-- use({ "rcarriga/nvim-dap-ui" })
-- use({ "Pocco81/DAPInstall.nvim" })

-- highlight search,
use({
    "kevinhwang91/nvim-hlslens",
    keys = {
        { "n", mode = { "n", "x", "o" } },
        { "N", mode = { "n", "x", "o" } },
        { "*", mode = { "n", "x", "o" } },
        { "#", mode = { "n", "x", "o" } },
        { "g*", mode = { "n", "x", "o" } },
        { "g#", mode = { "n", "x", "o" } },
    },
    config = function()
        require("config.plugins.hlslens")
    end,
})

-- evaluates code blocks
use({
    "jubnzv/mdeval.nvim",
    cmd = "MdEval",
    config = function()
        require("config.plugins.mdeval")
    end,
})

use({
    "danymat/neogen",
    keys = "<leader>/",
    config = function()
        require("config.plugins.neogen")
    end,
})

use({
    "iamcco/markdown-preview.nvim",
    config = function()
        require("config.plugins.markdown-preview")
    end,
    build = "cd app && npm install",
    cmd = "MarkdownPreview",
})

use({
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
})

use({
    "aserowy/tmux.nvim",
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<A-h>", "<A-j>", "<A-k>", "<A-l>" },
    config = true,
})

use({
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
        require("config.plugins.todo-comments")
    end,
})

use({
    "mfussenegger/nvim-treehopper",
    keys = { { "m", mode = { "o", "x" } } },
    dependencies = "hop.nvim",
    config = function()
        require("config.plugins.treehopper")
    end,
})

use({
    "gpanders/editorconfig.nvim",
    enabled = false,
    ft = { "lua" },
})

use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
        require("config.plugins.gitsigns")
    end,
})

use({
    "s1n7ax/nvim-window-picker",
    keys = { ",w", ",W" },
    config = function()
        require("config.plugins.window-picker")
    end,
})

use({
    "skywind3000/asyncrun.vim",
    cmd = "AsyncRun",
    config = function()
        require("config.plugins.asyncrun")
    end,
})

use({
    "simnalamburt/vim-mundo",
    cmd = "MundoToggle",
})
