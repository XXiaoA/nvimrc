local use = require("core.packer").add_plugin

-- 加快启动时间
use({ "lewis6991/impatient.nvim", config = "require('impatient')" })

-- Packer can manage itself
use({ "wbthomason/packer.nvim" })

-- bufferline #buffer
use({
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    event = "BufWinEnter",
    config = "require('config.plugins.bufferline')",
})

-- treesitter 高亮
use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = "require('config.plugins.nvim-treesitter')",
})

-- 彩色括号
use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })

-- 缩进线
use({
    "lukas-reineke/indent-blankline.nvim",
    event = "VimEnter",
    config = "require('config.plugins.indent-blankline')",
})

-- 状态栏
use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = "require('config.plugins.lualine')",
})

-- 按键
use({ "folke/which-key.nvim", event = "VimEnter", config = "require('config.plugins.which-key')" })

-- neo-tree
use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    event = "BufWinEnter",
    config = "require('config.plugins.neo-tree')",
})

use({
    "s1n7ax/nvim-window-picker",
    tag = "v1.*",
    after = "neo-tree.nvim",
    config = [[require("window-picker").setup() ]],
})

-- Comment 注释
use({ "numToStr/Comment.nvim", event = "VimEnter", config = "require('config.plugins.comment')" })

-- lspkind
use({ "onsails/lspkind-nvim", event = "VimEnter" })

-- nvim-cmp
use({ "hrsh7th/nvim-cmp", config = "require('config.plugins.cmp')", after = "lspkind-nvim" })
use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
use({ "petertriho/cmp-git", after = "nvim-cmp", config = [[ require("cmp_git").setup({}) ]] })

-- snippets
use({ "L3MON4D3/LuaSnip", event = "InsertEnter" })
use({ "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } })

-- 自动补全括号
use({ "windwp/nvim-autopairs", after = "nvim-cmp", config = "require('config.plugins.nvim-autopairs')" })

-- lspconfig
use({
    "neovim/nvim-lspconfig",
})

use({
    "williamboman/mason.nvim",
    branch = "alpha",
    config = function()
        require("config.plugins.mason")
    end,
})
use({ "williamboman/mason-lspconfig.nvim" })

-- dressing.nvim
use({ "stevearc/dressing.nvim", event = "VimEnter" })

-- lsp_signature
use({ "ray-x/lsp_signature.nvim", config = "require('config.plugins.lsp-signature')" })

-- 文件搜索 预览 等
use({
    "nvim-telescope/telescope.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        "jvgrootveld/telescope-zoxide",
    },
    cmd = "Telescope",
    config = "require('config.plugins.telescope')",
})

-- recent project
use({ "ahmedkhalf/project.nvim", after = "telescope.nvim", config = "require('config.plugins.project')" })

-- 加速文件搜索速度,如果安装失败需要到插件目录执行make命令手动编译
use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", after = "telescope.nvim" })

-- code outline
use({
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    config = "require('config.plugins.aerial')",
})

-- 颜色
use({
    "norcalli/nvim-colorizer.lua",
    event = "BufWinEnter",
    config = "require('config.plugins.nvim-colorizer')",
})

-- 命令行窗口
use({ "akinsho/toggleterm.nvim", event = "VimEnter", config = "require('config.plugins.toggleterm')" })

-- copilot
use({ "github/copilot.vim" })

-- 运行片段代码
use({
    "michaelb/sniprun",
    event = "VimEnter",
    run = "bash ./install.sh",
    config = "require('config.plugins.sniprun')",
})

-- 启动页
use({ "glepnir/dashboard-nvim", event = "VimEnter", config = "require('config.plugins.dashboard')" })

-- session
use({
    "Shatur/neovim-session-manager",
    event = "VimEnter",
    config = "require('config.plugins.neovim-session-manager')",
})

-- 自动对齐
use({ "junegunn/vim-easy-align", event = "VimEnter" })

-- vim-sandwich
use({ "machakann/vim-sandwich", event = "VimEnter" })
-- 自动保存
use({
    "Pocco81/AutoSave.nvim",
    event = "VimEnter",
    config = function()
        vim.defer_fn(function()
            require("config.plugins.auto-save")
        end, 1500)
    end,
})

-- 运行时间
use({ "dstein64/vim-startuptime", event = "VimEnter" })

-- 快速转跳
use({
    "phaazon/hop.nvim",
    branch = "v1", -- optional but strongly recommended
    event = "VimEnter",
    config = "require('config.plugins.hop')",
})

-- 中文文档
use({ "yianwillis/vimcdoc", event = "VimEnter" })

-- 格式化代码
use({
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = "require('config.plugins.formatter')",
})

-- 翻译
use({ "voldikss/vim-translator", cmd = "Translate" })

-- Debugging
use({ "mfussenegger/nvim-dap" })
use({ "rcarriga/nvim-dap-ui" })
use({ "Pocco81/DAPInstall.nvim" })
-- hightlight search,
use({ "kevinhwang91/nvim-hlslens", event = "VimEnter", config = "require('config.plugins.hlslens')" })

-- evaluates code blocks
use({ "jubnzv/mdeval.nvim", ft = "markdown", config = "require('config.plugins.mdeval')" })

-- register
use({ "tversteeg/registers.nvim", event = "VimEnter", config = [[vim.g.registers_window_border = "single"]] })

-- Delete Neovim buffers without losing window layout
use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })

use({ "nacro90/numb.nvim", event = "BufRead", config = [[require('numb').setup()]] })

use({
    "danymat/neogen",
    cmd = "Neogen",
    config = "require('config.plugins.neogen')",
})

use({
    "iamcco/markdown-preview.nvim",
    config = "require('config.plugins.markdown-preview')",
    ft = { "markdown" },
})
