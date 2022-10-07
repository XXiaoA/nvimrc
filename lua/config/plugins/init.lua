local use = require("core.packer").add_plugin

-- 加快启动时间
use({ "lewis6991/impatient.nvim", config = "require('impatient')" })

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
    keys = { "gc", "gb" },
    config = "require('config.plugins.comment')",
})

-- lspkind
use({ "onsails/lspkind-nvim", event = "BufWinEnter" })

-- nvim-cmp
use({
    "hrsh7th/nvim-cmp",
    requires = {
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
    },
    config = "require('config.plugins.cmp')",
    after = "lspkind-nvim",
})

-- snippets
use({ "L3MON4D3/LuaSnip", event = "InsertEnter" })
use({ "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } })

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

-- 加速文件搜索速度,如果安装失败需要到插件目录执行make命令手动编译
use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", after = "telescope.nvim" })

-- code outline
use({
    "stevearc/aerial.nvim",
    after = "telescope.nvim",
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
    event = "BufWinEnter",
    config = "require('config.plugins.toggleterm')",
})

-- session
use({
    "Shatur/neovim-session-manager",
    cmd = "SessionManager",
    config = "require('config.plugins.neovim-session-manager')",
})

-- 自动对齐
use({ "junegunn/vim-easy-align", cmd = "EasyAlign" })

use({
    "kylechui/nvim-surround",
    keys = { "<C-g>s", "<C-g>S", "sa", "ssa", "sA", "ssA", "sd", "sr" },
    config = function()
        require("config.plugins.surround")
    end,
})

-- 运行时间
use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

-- 快速转跳
use({
    "phaazon/hop.nvim",
    branch = "v1", -- optional but strongly recommended
    event = "BufWinEnter",
    config = "require('config.plugins.hop')",
})

-- 中文文档
use({ "yianwillis/vimcdoc", event = "BufWinEnter" })

-- 格式化代码
use({
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = "require('config.plugins.formatter')",
})

-- 翻译
use({ "voldikss/vim-translator", cmd = "Translate" })

-- TODO: configure it! (with rust-tools)
-- Debugging
-- use({ "mfussenegger/nvim-dap" })
-- use({ "rcarriga/nvim-dap-ui" })
-- use({ "Pocco81/DAPInstall.nvim" })

-- highlight search,
use({
    "kevinhwang91/nvim-hlslens",
    keys = { "n", "N", "*", "#", "g*", "g#" },
    config = "require('config.plugins.hlslens')",
})

-- evaluates code blocks
use({ "jubnzv/mdeval.nvim", ft = "markdown", config = "require('config.plugins.mdeval')" })

use({
    "danymat/neogen",
    cmd = "Neogen",
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
        require("tmux").setup({
            navigation = {
                -- enables default keybindings (C-hjkl) for normal mode
                enable_default_keybindings = true,
            },
        })
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
    opt = true,
})
-- packadd manually
require("config.plugins.treehopper")

use({
    "gpanders/editorconfig.nvim",
    ft = { "lua" },
})

use({
    "kana/vim-textobj-user",
    event = "BufWinEnter",
})
use({
    "beloglazov/vim-textobj-quotes",
    after = "vim-textobj-user",
    config = function()
        vim.keymap.set({ "x", "o" }, "q", "iq", { remap = true })
        vim.keymap.set({ "x", "o" }, "Q", "aq", { remap = true })
    end,
})

use({
    "lewis6991/gitsigns.nvim",
    event = "BufWinEnter",
    config = function()
        require("config.plugins.gitsigns")
    end,
})
