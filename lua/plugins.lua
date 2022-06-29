-- 在没有安装packer的电脑上，自动安装packer插件
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    -- fn.system({ "git", "clone", "--depth", "1", "https://hub.fastgit.xyz/wbthomason/packer.nvim.git", install_path })
    vim.cmd("packadd packer.nvim")
end

-- Mirror source
require("packer").init({
    git = {
        default_url_format = "https://github.com/%s",
        -- default_url_format = "https://hub.fastgit.xyz/%s"
    },
})

local all_plugins = {
    -- 加快启动时间
    { "lewis6991/impatient.nvim", config = "require('impatient')" },
    -- Packer can manage itself
    { "wbthomason/packer.nvim" },
    -- 主题
    { "sainnhe/gruvbox-material" },
    { "EdenEast/nightfox.nvim", tag = "v1.0.0" },
    -- bufferline #buffer
    {
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        event = "BufWinEnter",
        config = "require('config.plugins.bufferline')",
    },
    -- treesitter 高亮
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = "require('config.plugins.nvim-treesitter')",
    },
    -- 彩色括号
    { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
    -- 缩进线
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VimEnter",
        config = "require('config.plugins.indent-blankline')",
    },
    -- 状态栏
    {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = "require('config.plugins.lualine')",
    },
    -- neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        event = "BufWinEnter",
        config = "require('config.plugins.neo-tree')",
    },
    {
        "s1n7ax/nvim-window-picker",
        tag = "v1.*",
        after = "neo-tree.nvim",
        config = [[require("window-picker").setup() ]],
    },
    -- Comment 注释
    { "numToStr/Comment.nvim", event = "VimEnter", config = "require('config.plugins.comment')" },
    -- lspkind
    { "onsails/lspkind-nvim", event = "VimEnter" },
    -- nvim-cmp
    { "hrsh7th/nvim-cmp", config = "require('config.plugins.cmp')", after = "lspkind-nvim" },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
    { "hrsh7th/cmp-emoji", after = "nvim-cmp" },
    { "petertriho/cmp-git", after = "nvim-cmp", config = [[ require("cmp_git").setup({}) ]] },
    -- snippets
    { "rafamadriz/friendly-snippets" },
    { "L3MON4D3/LuaSnip", event = "InsertEnter" },
    { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
    -- 自动补全括号
    { "windwp/nvim-autopairs", after = "nvim-cmp", config = "require('config.plugins.nvim-autopairs')" },
    -- lspconfig
    { "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", "williamboman/nvim-lsp-installer" },
    -- dressing.nvim
    { "stevearc/dressing.nvim", after = "nvim-lspconfig" },
    -- lsp_signature
    { "ray-x/lsp_signature.nvim", config = "require('config.plugins.lsp-signature')" },
    -- 文件搜索 预览 等
    {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        cmd = "Telescope",
        config = "require('config.plugins.telescope')",
    },
    -- recent project
    { "ahmedkhalf/project.nvim", after = "telescope.nvim", config = "require('config.plugins.project')" },
    -- 加速文件搜索速度,如果安装失败需要到插件目录执行make命令手动编译
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make", after = "telescope.nvim" },
    -- code outline
    { "stevearc/aerial.nvim", after = "telescope.nvim", config = "require('config.plugins.aerial')" },
    -- 颜色
    {
        "norcalli/nvim-colorizer.lua",
        event = "BufWinEnter",
        config = "require('config.plugins.nvim-colorizer')",
    },
    -- 命令行窗口
    { "akinsho/toggleterm.nvim", event = "VimEnter", config = "require('config.plugins.toggleterm')" },
    -- copilot
    { "github/copilot.vim" },
    -- 运行片段代码
    {
        "michaelb/sniprun",
        event = "VimEnter",
        run = "bash ./install.sh",
        config = "require('config.plugins.sniprun')",
    },
    -- 启动页
    { "glepnir/dashboard-nvim", event = "VimEnter", config = "require('config.plugins.dashboard')" },
    -- 自动对齐
    { "junegunn/vim-easy-align", event = "VimEnter" },
    -- vim-sandwich
    { "machakann/vim-sandwich", event = "VimEnter" },
    -- 自动保存
    {
        "Pocco81/AutoSave.nvim",
        event = "VimEnter",
        config = function()
            vim.defer_fn(function()
                require("config.plugins.auto-save")
            end, 1500)
        end,
    },
    -- 运行时间
    { "dstein64/vim-startuptime", event = "VimEnter" },
    -- 快速转跳
    {
        "phaazon/hop.nvim",
        branch = "v1", -- optional but strongly recommended
        event = "VimEnter",
        config = "require('config.plugins.hop')",
    },
    -- 中文文档
    { "yianwillis/vimcdoc", event = "VimEnter" },
    -- 格式化代码
    {
        "mhartington/formatter.nvim",
        cmd = "Format",
        config = "require('config.plugins.formatter')",
    },
    -- 翻译
    { "voldikss/vim-translator", cmd = "Translate" },
    -- 按键
    { "folke/which-key.nvim", event = "VimEnter", config = "require('config.plugins.which-key')" },
    -- Debugging
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "Pocco81/DAPInstall.nvim" },
    -- hightlight search
    { "kevinhwang91/nvim-hlslens", event = "VimEnter" },
    -- evaluates code blocks
    { "jubnzv/mdeval.nvim", ft = "markdown", config = "require('config.plugins.mdeval')" },
    -- register
    { "tversteeg/registers.nvim", event = "VimEnter", config = [[vim.g.registers_window_border = "single"]] },
    -- Delete Neovim buffers without losing window layout
    { "famiu/bufdelete.nvim", cmd = "Bdelete" },
    -- marks
    { "chentoast/marks.nvim", event = "VimEnter", config = "require('config.plugins.marks')" },
}

return require("packer").startup(function()
    for _, plugin in ipairs(all_plugins) do
        ---@diagnostic disable-next-line: undefined-global
        use(plugin)
    end
end)
