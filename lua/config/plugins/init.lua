local use = require("core.packer").add_plugin

use({
    "lewis6991/impatient.nvim",
    config = function()
        require("impatient")
    end,
})

-- Packer can manage itself
use({ "wbthomason/packer.nvim" })

-- treesitter 高亮
use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = "require('config.plugins.nvim-treesitter')",
})

-- 彩色括号
use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })

-- 按键
use({
    "folke/which-key.nvim",
    event = "BufWinEnter",
    config = "require('config.plugins.which-key')",
})

-- Comment 注释
use({
    "numToStr/Comment.nvim",
    event = "BufWinEnter",
    config = "require('config.plugins.comment')",
})

-- snippets
use({
    "L3MON4D3/LuaSnip",
    after = "Comment.nvim",
    config = function()
        require("config.plugins.luasnip")
    end,
})

-- nvim-cmp
use({
    "hrsh7th/nvim-cmp",
    requires = {
        { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
    },
    config = "require('config.plugins.cmp')",
    after = "LuaSnip",
})

-- 自动补全括号
use({
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = "require('config.plugins.nvim-autopairs')",
})

-- 文件搜索 预览 等
use({
    "nvim-telescope/telescope.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
    },
    event = "BufWinEnter",
    config = "require('config.plugins.telescope')",
})

-- recent project
use({
    "ahmedkhalf/project.nvim",
    after = "telescope.nvim",
    config = "require('config.plugins.project')",
})

-- code outline
use({
    "stevearc/aerial.nvim",
    keys = { "[f", "]f", "<leader>aa", "<leader>fa" },
    config = "require('config.plugins.aerial')",
})

-- 颜色
use({
    "NvChad/nvim-colorizer.lua",
    cmd = "ColorizerAttachToBuffer",
    config = "require('config.plugins.nvim-colorizer')",
})

-- 命令行窗口
use({
    "akinsho/toggleterm.nvim",
    keys = { "<leader>tt", "<leader>tf", "<leader>ta" },
    config = "require('config.plugins.toggleterm')",
})

-- session
use({
    "Shatur/neovim-session-manager",
    keys = { "<leader>ss", "<leader>sl", "<leader>sc", "<leader>sd" },
    config = "require('config.plugins.neovim-session-manager')",
})

-- 自动对齐
use({ "junegunn/vim-easy-align", cmd = "EasyAlign" })

use({
    "kylechui/nvim-surround",
    event = "BufWinEnter",
    -- keys = { "<C-g>s", "<C-g>S", "sa", "ssa", "sA", "ssA", "sd", "sr" },
    config = function()
        require("config.plugins.surround")
    end,
})

use({
    "~/repos/ns-textobject.nvim/",
    after = "nvim-surround",
    config = function()
        require("config.plugins.ns-textobject")
    end,
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
        { "o", "t" },
        { "o", "T" },
        { "o", "f" },
        { "o", "F" },
        { "o", "se" },
        { "x", "t" },
        { "x", "T" },
        { "x", "f" },
        { "x", "F" },
        { "x", "se" },
        { "n", "t" },
        { "n", "T" },
        { "n", "f" },
        { "n", "F" },
        { "n", "se" },
    },
    config = "require('config.plugins.hop')",
})

-- 中文文档
use({ "yianwillis/vimcdoc", event = "BufWinEnter" })

-- 格式化代码
use({
    "mhartington/formatter.nvim",
    keys = "<leader>bf",
    config = "require('config.plugins.formatter')",
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
        { "x", "n" },
        { "x", "N" },
        { "x", "*" },
        { "x", "#" },
        { "x", "g*" },
        { "x", "g#" },
        { "o", "n" },
        { "o", "N" },
        { "o", "*" },
        { "o", "#" },
        { "o", "g*" },
        { "o", "g#" },
        { "n", "n" },
        { "n", "N" },
        { "n", "*" },
        { "n", "#" },
        { "n", "g*" },
        { "n", "g#" },
    },
    config = "require('config.plugins.hlslens')",
})

-- evaluates code blocks
use({ "jubnzv/mdeval.nvim", ft = "markdown", config = "require('config.plugins.mdeval')" })

use({
    "danymat/neogen",
    keys = "<leader>/",
    config = "require('config.plugins.neogen')",
})

use({
    "iamcco/markdown-preview.nvim",
    config = "require('config.plugins.markdown-preview')",
    run = "cd app && npm install",
    ft = { "markdown" },
})

use({
    "karb94/neoscroll.nvim",
    keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    config = [[require('neoscroll').setup()]],
})

use({
    "aserowy/tmux.nvim",
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<A-h>", "<A-j>", "<A-k>", "<A-l>" },
    config = function()
        require("tmux").setup({})
    end,
})

use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    after = "nvim-cmp",
    config = [[require("config.plugins.todo-comments")]],
})

use({
    "mfussenegger/nvim-treehopper",
    keys = { { "o", "m" }, { "x", "m" } },
    config = function()
        require("config.plugins.treehopper")
    end,
})

use({
    "gpanders/editorconfig.nvim",
    ft = { "lua" },
})

use({
    "lewis6991/gitsigns.nvim",
    event = "BufWinEnter",
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
